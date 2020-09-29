import 'dart:async';
import 'dart:io';

import 'package:famedlysdk/famedlysdk.dart';
import 'package:famedlysdk/matrix_api.dart';
import 'package:fluffychat/components/connection_status_header.dart';
import 'package:fluffychat/components/dialogs/simple_dialogs.dart';
import 'package:fluffychat/components/list_items/enia_presence_list_item.dart';
import 'package:fluffychat/components/list_items/private_room_list_item.dart';
import 'package:fluffychat/components/list_items/public_room_list_item.dart';
import 'package:fluffychat/views/chat.dart';
import 'package:fluffychat/views/enia_menu.dart';
import 'package:fluffychat/views/files_enia_menu.dart';
import 'package:fluffychat/views/stats_enia_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:share/share.dart';
import '../components/adaptive_page_layout.dart';
import '../components/list_items/chat_list_item.dart';
import '../components/matrix.dart';
import '../l10n/l10n.dart';
import '../utils/app_route.dart';
import '../utils/url_launcher.dart';
import 'archive.dart';
import 'formation_enia_menu.dart';
import 'homeserver_picker.dart';
import 'new_group.dart';
import 'new_private_chat.dart';
import 'settings.dart';

enum SelectMode { normal, share }

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

  Room linkMainRoom;
  Room secondLinkRoom;
  Room thirdLinkRoom;

  List<String> roomsJoined;

  List<User> mainGroupList;

  final ScrollController _scrollController = ScrollController();

  Future<void> waitForFirstSync(BuildContext context) async {
    if (secondLinkRoom == null) {
      await getSecondLink();
    }
    if (thirdLinkRoom == null) {
      await getThirdLink();
    }
    if (mainGroupList == null || mainGroupList.isEmpty) {
      await getMainGroup();
    }
    var client = Matrix.of(context).client;

    if (client.prevBatch?.isEmpty ?? true) {
      await client.onFirstSync.stream.first;
    }
    return true;
  }

  bool _scrolledToTop = true;

  Future getMainGroup() async {
    print('Entro FIRST LINK');
    var client = Matrix.of(context).client;

    roomsJoined == null
        ? roomsJoined = await client.requestJoinedRooms()
        : null;

    //print(roomsJoined.toString());

    var isMainGroupOnRooms = roomsJoined.contains(Matrix.mainGroup);

    //print(isMainGroupOnRooms);

    if (isMainGroupOnRooms) {
      //print('QUISO TRAER LISTA');
      linkMainRoom = await client.getRoomById(Matrix.mainGroup);

      List participantsMainGroup = await linkMainRoom.requestParticipants();

      if (participantsMainGroup.isNotEmpty) {
        var filteredMainGroupList = participantsMainGroup
            .where((user) => user.id != client.userID)
            .toList();

        setState(() => mainGroupList = filteredMainGroupList);
      }
    } else {
      //print('SET STATE NULL');
      setState(() => mainGroupList = null);
    }
  }

  Future getSecondLink() async {
    print('Entro SECOND LINK');
    var client = Matrix.of(context).client;

    roomsJoined == null
        ? roomsJoined = await client.requestJoinedRooms()
        : null;

    var isGroupOnRooms = roomsJoined.contains(Matrix.secondGroup);

    if (isGroupOnRooms) {
      secondLinkRoom = await client.getRoomById(Matrix.secondGroup);
    }

    return null;
  }

  Future getThirdLink() async {
    print('Entro THIRD LINK');
    var client = Matrix.of(context).client;

    roomsJoined == null
        ? roomsJoined = await client.requestJoinedRooms()
        : null;

    // List  groupsJoinedLink = await roomsJoined.any((room) => Matrix.thirdGroup.contains(room)).toList();

    /*   var groupsJoinedLink2 = roomsJoined
        .where((roomId) => Matrix.thirdGroup.contains(roomId))
        .toList(); */

    var groupsJoinedLink =
        roomsJoined.firstWhere((roomId) => Matrix.thirdGroup.contains(roomId));

    if (groupsJoinedLink != null) {
      thirdLinkRoom = await client.getRoomById(groupsJoinedLink);
      //print('ESTA EN GRUPO PROVINCIA');
    }
    
    return null;
  }

/*   Future getFirstEniaLink() async {
    var client = Matrix.of(context).client;

    final roomSalta = await client.getRoomById(Matrix.mainGroup);

    setState(() => mainGroupList.insert(0, roomSalta));

  } */

  /* Future getConditionalGroup() async {
    var client = Matrix.of(context).client;

    final roomMainGroup = await client.getRoomById(Matrix.mainGroup);

    List participantsMainGroup = await roomMainGroup.requestParticipants();

    var rooms = List<Room>.from(Matrix.of(context).client.rooms);

    List<User> isInMainGruop = participantsMainGroup
        .where((user) => user.id == client.userID)
        .toList();

    if (isInMainGruop.isNotEmpty) {
      print('Esta en Salta');
      print(isInMainGruop[0].displayName.toString());

      // Aca tengo que poner ID de salta config
      final roomSaltaConfig = await client.getRoomById(Matrix.mainGroup);

      List participantsSaltaGroupConfig =
          await roomSaltaConfig.requestParticipants();

      List<User> configListSalta = participantsSaltaGroupConfig
          .where((user) => user.id == client.userID)
          .toList();

      setState(() => mainGroupList.insertAll(0, configListSalta));
    }

    /* final roomMendoza = await client.getRoomById(Matrix.mainGroup);

    List participantsMendozaGroup = await roomMendoza.requestParticipants();

    List<User> isInMendozaGruop = participantsMendozaGroup
        .where((user) => user.id == client.userID)
        .toList();

    if (isInMendozaGruop.isNotEmpty) {
      print('Esta en Mendoza');
      print(isInMendozaGruop[0].displayName.toString());
      setState(() => mainGroupList.insertAll(0, isInMendozaGruop));
    }

    final roomTucuman = await client.getRoomById(Matrix.mainGroup);

    List participantsTucumanGroup = await roomTucuman.requestParticipants();

    List<User> isInTucumanGruop = participantsTucumanGroup
        .where((user) => user.id == client.userID)
        .toList();

    if (isInTucumanGruop.isNotEmpty) {
      print('Esta en Tucuman');
      print(isInTucumanGruop[0].displayName.toString());
      setState(() => mainGroupList.insertAll(0, isInTucumanGruop));
    } */
  } */

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
    _initReceiveSharingINtent();
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
      ),
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

  void _initReceiveSharingINtent() {
    if (kIsWeb) return;

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

  void _setStatus(BuildContext context) async {
    Navigator.of(context).pop();
    final status = await SimpleDialogs(context).enterText(
      multiLine: true,
      titleText: L10n.of(context).setStatus,
      labelText: L10n.of(context).setStatus,
      hintText: L10n.of(context).statusExampleMessage,
    );
    if (status?.isEmpty ?? true) return;
    await SimpleDialogs(context).tryRequestWithLoadingDialog(
      Matrix.of(context).client.sendPresence(
          Matrix.of(context).client.userID, PresenceType.online,
          statusMsg: status),
    );
  }

  /* void createRoomFromLink(BuildContext context, String linkRoomId) async {
    final matrix = Matrix.of(context);

    /* final user = User(
      '@' + userToAdd + ':matrix.codigoi.com.ar',
      room: Room(id: '', client: matrix.client),
    );
    final String roomID = await SimpleDialogs(context)
        .tryRequestWithLoadingDialog(user.startDirectChat()); */

    //asesor 1
    // final roomID = '!AQrUGRshYEMcsMOysZ:matrix.codigoi.com.ar';

    //ENIA
    //final roomID = '!HYkJsTHlawQWyzwLYK:matrix.codigoi.com.ar';

    //Eugneia Adolescente 2
    // final roomID = '!HUkIrSJsZwSSSDUbhD:matrix.codigoi.com.ar';

    //Victoria Adolescente 1
    //final roomID = '!EJOLABjfUsFDLIEhLF:matrix.codigoi.com.ar';

    //SALTA
    //final roomID = '!hDRSwvGOzbWxSaBckL:matrix.codigoi.com.ar';

    //Asesor 2
    // final roomID = '!EFpaaQkUzRDyLmhSdM:matrix.codigoi.com.ar';

    //Juanma
    //final roomID = '!URqoQQYUfuXBSGvMaW:matrix.codigoi.com.ar';

    var roomID = linkRoomId;

    if (roomID != null) {
      await Navigator.of(context).push(
        AppRoute.defaultRoute(
          context,
          ChatView(roomID),
        ),
      );
    }
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
                    ? SelectMode.normal
                    : SelectMode.share;
                return Scaffold(
                  drawer: selectMode == SelectMode.share
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
                                  onTap: () => _setStatus(context),
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
                                  //TODO: poner texto con L10n
                                  title: Text('enia@virtual'),
                                  //title: Text(L10n.of(context).archive),
                                  onTap: () => _drawerTapAction(
                                    EniaMenuView(),
                                  ),
                                ),
                                Divider(height: 1),
                                ListTile(
                                  leading: Icon(Icons.folder),
                                  //TODO: poner texto con L10n
                                  title: Text('Documentos'),
                                  //title: Text(L10n.of(context).archive),
                                  onTap: () => _drawerTapAction(
                                    FilesEniaMenuView(),
                                  ),
                                ),
                                Divider(height: 1),
                                ListTile(
                                  leading: Icon(Icons.school),
                                  //TODO: poner texto con L10n
                                  title: Text('Capacitación'),
                                  //title: Text(L10n.of(context).archive),
                                  onTap: () => _drawerTapAction(
                                    FormationEniaMenuView(),
                                  ),
                                ),
                                Divider(height: 1),
                                ListTile(
                                  leading: Icon(Icons.insert_chart),
                                  //TODO: poner texto con L10n
                                  title: Text('Estadisticas'),
                                  //title: Text(L10n.of(context).archive),
                                  onTap: () => _drawerTapAction(
                                    StatsEniaMenuView(),
                                  ),
                                ),
                                Divider(height: 1),

                                ListTile(
                                  leading: Icon(Icons.archive),
                                  //TODO: poner texto con L10n
                                  title: Text('Historial'),
                                  //title: Text(L10n.of(context).archive),
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
                    //elevation: _scrolledToTop ? 0 : null,
                    leading: selectMode != SelectMode.share
                        ? null
                        : IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () =>
                                Matrix.of(context).shareContent = null,
                          ),
                    titleSpacing: 0,
                    title: selectMode == SelectMode.share
                        ? Text(L10n.of(context).share)
                        : Padding(
                            padding:
                                EdgeInsets.only(top: 8, bottom: 8, right: 8),
                            child: TextField(
                              autocorrect: false,
                              controller: searchController,
                              focusNode: _searchFocusNode,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(9),
                                border: InputBorder.none,
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
                  //This allows to create new chats, not available on version 1
                  /* floatingActionButton:
                      (AdaptivePageLayout.columnMode(context) ||
                              selectMode == SelectMode.share)
                          ? null
                          : FloatingActionButton(
                              child: Icon(Icons.add),
                              backgroundColor: Theme.of(context).primaryColor,
                              onPressed: () => Navigator.of(context)
                                  .pushAndRemoveUntil(
                                      AppRoute.defaultRoute(
                                          context, NewPrivateChatView()),
                                      (r) => r.isFirst),
                            ), */
                  body: StreamBuilder(
                      stream: Matrix.of(context)
                          .client
                          .onSync
                          .stream
                          .where((s) => s.hasRoomUpdate),
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
                                      !room.displayname.toLowerCase().contains(
                                          searchController.text.toLowerCase() ??
                                              '')));

                              //This allows to search in listGrupoENia
                              if (mainGroupList != null &&
                                  mainGroupList.isNotEmpty) {
                                mainGroupList.removeWhere((User item) =>
                                    (searchMode &&
                                        !item.displayName
                                            .toString()
                                            .toLowerCase()
                                            .contains(searchController.text
                                                    .toLowerCase() ??
                                                '')));
                              }

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
                                  (publicRoomsResponse?.chunk?.length ?? 0);
                              final totalCount =
                                  rooms.length + publicRoomsCount;
                              /*  final directChats =
                                  rooms.where((r) => r.isDirectChat).toList();

                              final presences =
                                  Matrix.of(context).client.presences;

                              directChats.sort((a, b) =>
                                  presences[b.directChatMatrixID]
                                              ?.presence
                                              ?.statusMsg !=
                                          null
                                      ? 1
                                      : b.lastEvent.originServerTs.compareTo(
                                          a.lastEvent.originServerTs)); */

                              return ListView.separated(
                                  controller: _scrollController,
                                  separatorBuilder: (BuildContext context,
                                          int i) =>
                                      i == totalCount - publicRoomsCount
                                          ? ListTile(
                                              title: Text(
                                                L10n.of(context).publicRooms +
                                                    ':',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                  itemCount: totalCount + 1,
                                  itemBuilder: (BuildContext context, int i) {
                                    if (i == 0) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ConnectionStatusHeader(),
                                          /* Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              RaisedButton(
                                                child: Text('ENIA'),
                                                onPressed: () {
                                                  createRoomFromLink(context,
                                                      '!HYkJsTHlawQWyzwLYK:matrix.codigoi.com.ar');
                                                },
                                              ),
                                              RaisedButton(
                                                child: Text('AYUDA'),
                                                onPressed: () {
                                                  createRoomFromLink(context,
                                                      '!HYkJsTHlawQWyzwLYK:matrix.codigoi.com.ar');
                                                },
                                              ),
                                            ],
                                          ), */
                                          (mainGroupList == null ||
                                                  selectMode ==
                                                      SelectMode.share)
                                              ? Container()
                                              : PreferredSize(
                                                  preferredSize:
                                                      Size.fromHeight(90),
                                                  child: Container(
                                                    height: 84,
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: mainGroupList
                                                            .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int i) {
                                                          if (i == 0) {
                                                            return Row(
                                                              children: <
                                                                  Widget>[
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
                                                                            child:
                                                                                PrivateRoomListItem(secondLinkRoom),
                                                                          ),

                                                                searchMode
                                                                    ? Container()
                                                                    : thirdLinkRoom ==
                                                                            null
                                                                        ? Container()
                                                                        : Container(
                                                                            child:
                                                                                PrivateRoomListItem(thirdLinkRoom),
                                                                          ),
                                                                // Avatar(linkMainRoom.avatar, linkMainRoom.displayname),

                                                                /* FlatButton(
                                                                  child: Text(
                                                                      'AYUDA'),
                                                                  onPressed:
                                                                      () {
                                                                    createRoomFromLink(
                                                                        context,
                                                                        '!POwBopuroioZAsSpNy:matrix.codigoi.com.ar');
                                                                  },
                                                                ), */
                                                                EniaPresenceListItem(
                                                                    mainGroupList[
                                                                        i]),
                                                              ],
                                                            );
                                                          } else {
                                                            return EniaPresenceListItem(
                                                                mainGroupList[
                                                                    i]);
                                                          }
                                                        }),
                                                  ),
                                                ),

                                          // Is direct is not displayed on ENIA APP
                                          /*  (directChats.isEmpty ||
                                                  selectMode ==
                                                      SelectMode.share)
                                              ? Container()
                                              //This shows added contacts on chat
                                              // Esto muestra los contactos arriba del listado de chats
                                              : PreferredSize(
                                                  preferredSize:
                                                      Size.fromHeight(90),
                                                  child: Container(
                                                    height: 84,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          directChats.length,
                                                      itemBuilder: (BuildContext
                                                                  context,
                                                              int i) =>
                                                          PresenceListItem(
                                                              directChats[i]),
                                                    ),
                                                  ),
                                                ), */
                                        ],
                                      );
                                    }
                                    i--;
                                    return i < rooms.length
                                        ? ChatListItem(
                                            rooms[i],
                                            activeChat: widget.activeChat ==
                                                rooms[i].id,
                                          )
                                        : PublicRoomListItem(publicRoomsResponse
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
                );
              });
        });
  }
}
