import 'dart:async';
import 'dart:io';

import 'package:famedlysdk/famedlysdk.dart';
import 'package:famedlysdk/matrix_api.dart';
// import 'package:fluffychat/components/avatar.dart';
import 'package:fluffychat/components/connection_status_header.dart';
import 'package:fluffychat/components/dialogs/simple_dialogs.dart';
// import 'package:fluffychat/components/list_items/status_list_item.dart';
import 'package:fluffychat/components/list_items/public_room_list_item.dart';
import 'package:fluffychat/components/list_items/enia_presence_list_item.dart';
import 'package:fluffychat/components/list_items/private_room_list_item.dart';
import 'package:fluffychat/stats_dashboard/dashboard_menu_screen.dart';
import 'package:fluffychat/views/enia_menu.dart';
import 'package:fluffychat/views/files_enia_menu.dart';
import 'package:fluffychat/utils/platform_infos.dart';
// import 'package:fluffychat/views/status_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
// import 'package:share/share.dart';

import '../components/adaptive_page_layout.dart';
import '../components/list_items/chat_list_item.dart';
import '../components/matrix.dart';
import '../utils/app_route.dart';
import '../utils/matrix_file_extension.dart';
import '../utils/url_launcher.dart';
import 'archive.dart';
import 'formation_enia_menu.dart';
import 'library_enia_menu.dart';
import 'maps_enia_menu.dart';
import 'homeserver_picker.dart';
// import 'new_private_chat.dart';
import 'settings.dart';

enum SelectMode { normal, share, select }

class ChatListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.FIRST,
      firstScaffold: ChatList(),
      secondScaffold: Scaffold(
        body: Center(
          child: Image.asset('assets/logo.png', width: 100, height: 100),
        ),
      ),
    );
  }
}

class ChatList extends StatefulWidget {
  final String activeChat;

  const ChatList({this.activeChat, Key key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  bool get searchMode => searchController.text?.isNotEmpty ?? false;
  final TextEditingController searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Timer coolDown;
  PublicRoomsResponse publicRoomsResponse;
  bool loadingPublicRooms = false;
  String searchServer;
  final _selectedRoomIds = <String>{};

  List<String> roomsJoined;
  List<User> mainGroupList;

  Room linkMainRoom;
  bool resultMainLink = false;
  Room secondLinkRoom;
  bool resultSecondLink = false;
  Room thirdLinkRoom;
  bool resultThirdLink = false;

  final ScrollController _scrollController = ScrollController();

  void _toggleSelection(String roomId) =>
      setState(() => _selectedRoomIds.contains(roomId)
          ? _selectedRoomIds.remove(roomId)
          : _selectedRoomIds.add(roomId));

  Future<void> waitForFirstSync(BuildContext context) async {
    if (!resultSecondLink) {
      resultSecondLink = await getSecondLink();
    }
    if (!resultMainLink) {
      resultMainLink = await getMainGroup();
    }
    var client = Matrix.of(context).client;

    if (client.prevBatch?.isEmpty ?? true) {
      await client.onFirstSync.stream.first;
    }
    return true;
  }

  bool _scrolledToTop = true;

  Future<bool> getMainGroup() async {
    // print('Entro FIRST LINK');
    var client = Matrix.of(context).client;

    roomsJoined = await client.requestJoinedRooms();

    var isMainGroupOnRooms = roomsJoined.contains(Matrix.mainGroup);

    if (isMainGroupOnRooms) {
      linkMainRoom = await client.getRoomById(Matrix.mainGroup);

      List participantsMainGroup = await linkMainRoom.requestParticipants();

      if (participantsMainGroup.isNotEmpty) {
        var filteredMainGroupList = participantsMainGroup
            .where((user) => user.id != client.userID)
            .toList();

        setState(() => mainGroupList = filteredMainGroupList);
      }
    } else {
      setState(() => mainGroupList = null);
    }
    return true;
  }

  Future<bool> getSecondLink() async {
    // print('Entro SECOND LINK');
    var client = Matrix.of(context).client;

    roomsJoined == null
        ? roomsJoined = await client.requestJoinedRooms()
        : null;

    var isGroupOnRooms = roomsJoined.contains(Matrix.secondGroup);

    if (isGroupOnRooms) {
      var getSecondLinkRoom = await client.getRoomById(Matrix.secondGroup);
      setState(() => secondLinkRoom = getSecondLinkRoom);
    }

    return true;
  }

  @override
  void initState() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels > 0 && _scrolledToTop) {
        setState(() => _scrolledToTop = false);
      } else if (_scrollController.position.pixels == 0 && !_scrolledToTop) {
        setState(() => _scrolledToTop = true);
      }
    });
    searchController.addListener(() {
      coolDown?.cancel();
      if (searchController.text.isEmpty) {
        setState(() {
          loadingPublicRooms = false;
          publicRoomsResponse = null;
        });
        return;
      }
      coolDown = Timer(Duration(seconds: 1), () async {
        setState(() => loadingPublicRooms = true);
        final newPublicRoomsResponse =
            await SimpleDialogs(context).tryRequestWithErrorToast(
          Matrix.of(context).client.searchPublicRooms(
                limit: 30,
                includeAllNetworks: true,
                genericSearchTerm: searchController.text,
                server: searchServer,
              ),
        );
        setState(() {
          loadingPublicRooms = false;
          if (newPublicRoomsResponse != false) {
            publicRoomsResponse = newPublicRoomsResponse;
            if (searchController.text.isNotEmpty &&
                searchController.text.isValidMatrixId &&
                searchController.text.sigil == '#') {
              publicRoomsResponse.chunk.add(
                PublicRoom.fromJson({
                  'aliases': [searchController.text],
                  'name': searchController.text,
                  'room_id': searchController.text,
                }),
              );
            }
          }
        });
      });
      setState(() => null);
    });
    _initReceiveSharingIntent();
    super.initState();
  }

  void logoutAction(BuildContext context) async {
    if (await SimpleDialogs(context).askConfirmation() == false) {
      return;
    }
    var matrix = Matrix.of(context);
    await SimpleDialogs(context)
        .tryRequestWithLoadingDialog(matrix.client.logout());
  }

  StreamSubscription _intentDataStreamSubscription;

  StreamSubscription _intentFileStreamSubscription;

  void _processIncomingSharedFiles(List<SharedMediaFile> files) {
    if (files?.isEmpty ?? true) return;
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).popUntil((r) => r.isFirst);
    }
    final file = File(files.first.path);

    Matrix.of(context).shareContent = {
      'msgtype': 'chat.fluffy.shared_file',
      'file': MatrixFile(
        bytes: file.readAsBytesSync(),
        name: file.path,
      ).detectFileType,
    };
  }

  void _processIncomingSharedText(String text) {
    if (text == null) return;
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).popUntil((r) => r.isFirst);
    }
    if (text.startsWith('https://matrix.to/#/')) {
      UrlLauncher(context, text).openMatrixToUrl();
      return;
    }
    Matrix.of(context).shareContent = {
      'msgtype': 'm.text',
      'body': text,
    };
  }

  void _initReceiveSharingIntent() {
    if (!PlatformInfos.isMobile) return;

    // For sharing images coming from outside the app while the app is in the memory
    _intentFileStreamSubscription = ReceiveSharingIntent.getMediaStream()
        .listen(_processIncomingSharedFiles, onError: print);

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then(_processIncomingSharedFiles);

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = ReceiveSharingIntent.getTextStream()
        .listen(_processIncomingSharedText, onError: print);

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then(_processIncomingSharedText);
  }

  void _drawerTapAction(Widget view) {
    Navigator.of(context).pop();
    Navigator.of(context).pushAndRemoveUntil(
      AppRoute.defaultRoute(
        context,
        view,
      ),
      (r) => r.isFirst,
    );
  }

  /* void _setStatus(BuildContext context, {bool fromDrawer = false}) async {
    if (fromDrawer) Navigator.of(context).pop();
    final ownProfile = await SimpleDialogs(context)
        .tryRequestWithLoadingDialog(Matrix.of(context).client.ownProfile);
    String composeText;
    if (Matrix.of(context).shareContent != null &&
        Matrix.of(context).shareContent['msgtype'] == 'm.text') {
      composeText = Matrix.of(context).shareContent['body'];
      Matrix.of(context).shareContent = null;
    }
    if (ownProfile is Profile) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => StatusView(
            composeMode: true,
            avatarUrl: ownProfile.avatarUrl,
            displayname: ownProfile.displayname ??
                Matrix.of(context).client.userID.localpart,
            composeText: composeText,
          ),
        ),
      );
    }
    return;
  } */

  @override
  void dispose() {
    searchController.removeListener(
      () => setState(() => null),
    );
    _intentDataStreamSubscription?.cancel();
    _intentFileStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _toggleFavouriteRoom(BuildContext context) {
    final room = Matrix.of(context).client.getRoomById(_selectedRoomIds.single);
    return SimpleDialogs(context).tryRequestWithLoadingDialog(
      room.setFavourite(!room.isFavourite),
    );
  }

  Future<void> _toggleMuted(BuildContext context) {
    final room = Matrix.of(context).client.getRoomById(_selectedRoomIds.single);
    return SimpleDialogs(context).tryRequestWithLoadingDialog(
      room.setPushRuleState(room.pushRuleState == PushRuleState.notify
          ? PushRuleState.mentions_only
          : PushRuleState.notify),
    );
  }

  Future<void> _archiveAction(BuildContext context) async {
    final confirmed = await SimpleDialogs(context).askConfirmation();
    if (!confirmed) return;
    await SimpleDialogs(context)
        .tryRequestWithLoadingDialog(_archiveSelectedRooms(context));
    setState(() => null);
  }

  Future<void> _archiveSelectedRooms(BuildContext context) async {
    final client = Matrix.of(context).client;
    while (_selectedRoomIds.isNotEmpty) {
      final roomId = _selectedRoomIds.first;
      await client.getRoomById(roomId).leave();
      _selectedRoomIds.remove(roomId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LoginState>(
        stream: Matrix.of(context).client.onLoginStateChanged.stream,
        builder: (context, snapshot) {
          if (snapshot.data == LoginState.loggedOut) {
            Timer(Duration(seconds: 1), () {
              Matrix.of(context).clean();
              Navigator.of(context).pushAndRemoveUntil(
                  AppRoute.defaultRoute(context, HomeserverPicker()),
                  (r) => false);
            });
          }
          return StreamBuilder(
              stream: Matrix.of(context).onShareContentChanged.stream,
              builder: (context, snapshot) {
                final selectMode = Matrix.of(context).shareContent == null
                    ? _selectedRoomIds.isEmpty
                        ? SelectMode.normal
                        : SelectMode.select
                    : SelectMode.share;
                if (selectMode == SelectMode.share) {
                  _selectedRoomIds.clear();
                }
                return Scaffold(
                  drawer: selectMode != SelectMode.normal
                      ? null
                      : Drawer(
                          child: SafeArea(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: <Widget>[
                                // Opcion Menu Establecer estado, no disponible en version 1
                                /* ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text(L10n.of(context).setStatus),
                                  onTap: () =>
                                      _setStatus(context, fromDrawer: true),
                                ),
                                Divider(height: 1), */
                                // Opcion Crear grupo y chat privado , no disponible en version 1
                                /* ListTile(
                                  leading: Icon(Icons.people_outline),
                                  title: Text(L10n.of(context).createNewGroup),
                                  onTap: () => _drawerTapAction(NewGroupView()),
                                ),
                                ListTile(
                                  leading: Icon(Icons.person_add),
                                  title: Text(L10n.of(context).newPrivateChat),
                                  onTap: () =>
                                      _drawerTapAction(NewPrivateChatView()),
                                ),
                                Divider(height: 1), */
                                SizedBox(height: 20),
                                ListTile(
                                  leading: Image.asset(
                                    'assets/logoSoloFondo.png',
                                    width: 22,
                                  ),
                                  title: Text(L10n.of(context).projectName),
                                  onTap: () => _drawerTapAction(
                                    EniaMenuView(),
                                  ),
                                ),
                                Divider(height: 1),
                                ListTile(
                                  leading: Icon(Icons.folder),
                                  title: Text(L10n.of(context).documents),
                                  onTap: () => _drawerTapAction(
                                    FilesEniaMenuView(),
                                  ),
                                ),
                                Divider(height: 1),
                                ListTile(
                                  leading: Icon(Icons.school),
                                  title: Text(L10n.of(context).formation),
                                  onTap: () => _drawerTapAction(
                                    FormationEniaMenuView(),
                                  ),
                                ),
                                Divider(height: 1),
                                ListTile(
                                  leading: Icon(Icons.library_books),
                                  title: Text(L10n.of(context).library),
                                  onTap: () => _drawerTapAction(
                                    LibraryEniaMenuView(),
                                  ),
                                ),
                                Divider(height: 1),
                                ListTile(
                                  leading: Icon(Icons.insert_chart),
                                  title: Text(L10n.of(context).statsTitle),
                                  onTap: () => _drawerTapAction(
                                    StatsEniaMenuView(),
                                  ),
                                ),
                                Divider(height: 1),
                                ListTile(
                                  leading: Icon(Icons.map),
                                  title: Text(L10n.of(context).mapsTitle),
                                  onTap: () => _drawerTapAction(
                                    MapsEniaMenuView(),
                                  ),
                                ),
                                Divider(height: 1),

                                ListTile(
                                  leading: Icon(Icons.archive),
                                  title: Text(L10n.of(context).archive),
                                  onTap: () => _drawerTapAction(
                                    Archive(),
                                  ),
                                ),
                                Divider(height: 1),
                                ListTile(
                                  leading: Icon(Icons.settings),
                                  title: Text(L10n.of(context).settings),
                                  onTap: () => _drawerTapAction(
                                    SettingsView(),
                                  ),
                                ),
                                // Invitar contactos, no disponible en version 1
                                /* Divider(height: 1),
                                ListTile(
                                  leading: Icon(Icons.share),
                                  title: Text(L10n.of(context).inviteContact),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Share.share(L10n.of(context).inviteText(
                                        Matrix.of(context).client.userID,
                                        'https://matrix.to/#/${Matrix.of(context).client.userID}'));
                                  },
                                ), */
                                Divider(height: 1),
                                ListTile(
                                  leading: Icon(Icons.exit_to_app),
                                  title: Text(L10n.of(context).logout),
                                  onTap: () => logoutAction(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                  appBar: AppBar(
                    centerTitle: false,
                    elevation: _scrolledToTop ? 0 : null,
                    leading: selectMode == SelectMode.share
                        ? IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () =>
                                Matrix.of(context).shareContent = null,
                          )
                        : selectMode == SelectMode.select
                            ? IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () =>
                                    setState(_selectedRoomIds.clear),
                              )
                            : null,
                    titleSpacing: 0,
                    actions: selectMode != SelectMode.select
                        ? null
                        : [
                            if (_selectedRoomIds.length == 1)
                              IconButton(
                                icon: Icon(Icons.favorite_border_outlined),
                                onPressed: () => _toggleFavouriteRoom(context),
                              ),
                            if (_selectedRoomIds.length == 1)
                              IconButton(
                                icon: Icon(Icons.notifications_none),
                                onPressed: () => _toggleMuted(context),
                              ),
                            IconButton(
                              icon: Icon(Icons.archive),
                              onPressed: () => _archiveAction(context),
                            ),
                          ],
                    title: selectMode == SelectMode.share
                        ? Text(L10n.of(context).share)
                        : selectMode == SelectMode.select
                            ? Text(_selectedRoomIds.length.toString())
                            : Container(
                                height: 40,
                                padding: EdgeInsets.only(right: 8),
                                child: Material(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  borderRadius: BorderRadius.circular(32),
                                  child: TextField(
                                    autocorrect: false,
                                    controller: searchController,
                                    focusNode: _searchFocusNode,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        top: 8,
                                        bottom: 8,
                                        left: 16,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      hintText: L10n.of(context).searchForAChat,
                                      suffixIcon: searchMode
                                          ? IconButton(
                                              icon: Icon(Icons.backspace),
                                              onPressed: () => setState(() {
                                                searchController.clear();
                                                _searchFocusNode.unfocus();
                                              }),
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                  ),
                  //This allows to create new chats and set Status, not available on version 1
                  /*floatingActionButton:
                      (AdaptivePageLayout.columnMode(context) ||
                              selectMode != SelectMode.normal)
                          ? null
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FloatingActionButton(
                                  heroTag: null,
                                  child: Icon(
                                    Icons.edit,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  elevation: 1,
                                  backgroundColor:
                                      Theme.of(context).secondaryHeaderColor,
                                  onPressed: () => _setStatus(context),
                                ),
                                // SizedBox(height: 16.0),
                                FloatingActionButton(
                                  child: Icon(Icons.add),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  onPressed: () => Navigator.of(context)
                                      .pushAndRemoveUntil(
                                          AppRoute.defaultRoute(
                                              context, NewPrivateChatView()),
                                          (r) => r.isFirst),
                                ), 
                              ],
                            ),*/
                  body: Column(
                    children: [
                      ConnectionStatusHeader(),
                      Expanded(
                        child: StreamBuilder(
                            stream:
                                Matrix.of(context).client.onSync.stream.where(
                                      (s) =>
                                          s.hasRoomUpdate ||
                                          s.accountData
                                              .where((a) =>
                                                  a.type ==
                                                  MatrixState.userStatusesType)
                                              .isNotEmpty,
                                    ),
                            builder: (context, snapshot) {
                              return FutureBuilder<void>(
                                future: waitForFirstSync(context),
                                builder: (BuildContext context, snapshot) {
                                  if (snapshot.hasData) {
                                    var rooms = List<Room>.from(
                                        Matrix.of(context).client.rooms);
                                    rooms.removeWhere((Room room) =>
                                        room.lastEvent == null ||
                                        (searchMode &&
                                            !room.displayname
                                                .toLowerCase()
                                                .contains(searchController.text
                                                        .toLowerCase() ??
                                                    '')));

                                    // ignore: avoid_init_to_null
                                    var mainGroupListSearch = null;
                                    //This allows to search in listGrupoENia
                                    if (mainGroupList != null) {
                                      mainGroupListSearch =
                                          List<User>.from(mainGroupList);
                                    }

                                    if (mainGroupListSearch != null &&
                                        mainGroupListSearch.isNotEmpty) {
                                      mainGroupListSearch.removeWhere(
                                        (User item) => (searchMode &&
                                                !item.displayName
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains(searchController
                                                            .text
                                                            .toLowerCase() ??
                                                        '') ||
                                            searchMode &&
                                                !item.id
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains(searchController
                                                            .text
                                                            .toLowerCase() ??
                                                        '')),
                                      );
                                    }

                                    var e = 0;
                                    if (rooms.isEmpty &&
                                        (!searchMode ||
                                            publicRoomsResponse == null)) {
                                      return Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              searchMode
                                                  ? Icons.search
                                                  : Icons.chat_bubble_outline,
                                              size: 80,
                                              color: Colors.grey,
                                            ),
                                            Text(searchMode
                                                ? L10n.of(context).noRoomsFound
                                                : L10n.of(context)
                                                    .startYourFirstChat),
                                          ],
                                        ),
                                      );
                                    }
                                    final publicRoomsCount =
                                        (publicRoomsResponse?.chunk?.length ??
                                            0);
                                    final totalCount =
                                        rooms.length + publicRoomsCount + 1;
                                    return ListView.separated(
                                        controller: _scrollController,
                                        separatorBuilder: (BuildContext context,
                                                int i) =>
                                            i == totalCount - publicRoomsCount
                                                ? ListTile(
                                                    title: Text(
                                                      L10n.of(context)
                                                              .publicRooms +
                                                          ':',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                        itemCount: totalCount,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          if (e == 0) {
                                            e = 1;
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  height: 78,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        mainGroupListSearch
                                                            .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int i) {
                                                      if (i == 0) {
                                                        return Row(
                                                          children: <Widget>[
                                                            searchMode
                                                                ? Container()
                                                                : Container(
                                                                    child: PrivateRoomListItem(
                                                                        linkMainRoom),
                                                                  ),
                                                            searchMode
                                                                ? Container()
                                                                : secondLinkRoom ==
                                                                        null
                                                                    ? Container()
                                                                    : Container(
                                                                        child: PrivateRoomListItem(
                                                                            secondLinkRoom),
                                                                      ),
                                                            EniaPresenceListItem(
                                                                mainGroupListSearch[
                                                                    i]),
                                                          ],
                                                        );
                                                      } else {
                                                        return EniaPresenceListItem(
                                                            mainGroupListSearch[
                                                                i]);
                                                      }
                                                    },
                                                  ),
                                                )
                                              ],
                                            );
                                          }
                                          i--;
                                          return i < rooms.length
                                              ? ChatListItem(
                                                  rooms[i],
                                                  selected: _selectedRoomIds
                                                      .contains(rooms[i].id),
                                                  onTap: selectMode ==
                                                          SelectMode.select
                                                      ? () => _toggleSelection(
                                                          rooms[i].id)
                                                      : null,
                                                  onLongPress: selectMode !=
                                                          SelectMode.share
                                                      ? () => _toggleSelection(
                                                          rooms[i].id)
                                                      : null,
                                                  activeChat:
                                                      widget.activeChat ==
                                                          rooms[i].id,
                                                )
                                              : PublicRoomListItem(
                                                  publicRoomsResponse
                                                      .chunk[i - rooms.length]);
                                        });
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
