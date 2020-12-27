import 'package:famedlysdk/famedlysdk.dart';
import 'package:fluffychat/components/dialogs/presence_dialog.dart';
import 'package:fluffychat/utils/app_route.dart';
import 'package:fluffychat/views/chat.dart';
import 'package:flutter/material.dart';
import '../avatar.dart';
import '../matrix.dart';

class EniaPresenceListItem extends StatefulWidget {
  final User user;

  const EniaPresenceListItem(this.user);

  @override
  _EniaPresenceListItemState createState() => _EniaPresenceListItemState();
}

class _EniaPresenceListItemState extends State<EniaPresenceListItem> {
  bool botonIsUsed = true;

  void _startChatAction(BuildContext context, String userId) async {
    //print('START CHAT');
    botonIsUsed = false;
    final roomId = await User(userId,
            room: Room(client: Matrix.of(context).client, id: ''))
        .startDirectChat();
    botonIsUsed = true;
    await Navigator.of(context).pushAndRemoveUntil(
        AppRoute.defaultRoute(
          context,
          ChatView(roomId),
        ),
        (Route r) => r.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    // final user = room.getUserByMXIDSync(room.directChatMatrixID);
    final presence = Matrix.of(context).client.presences[widget.user];

    return InkWell(
      onTap: () => presence?.presence?.statusMsg == null
          ? botonIsUsed
              ? _startChatAction(context, widget.user.id)
              : null
          : showDialog(
              context: context,
              builder: (_) => PresenceDialog(
                presence,
                avatarUrl: widget.user.avatarUrl,
                displayname: widget.user.calcDisplayname(),
              ),
            ),
      child: Container(
        width: 76,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              child:
                  Avatar(widget.user.avatarUrl, widget.user.calcDisplayname()),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(80),
              ),
              padding: EdgeInsets.all(2),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0, top: 0.0, right: 6.0),
              child: Text(
                widget.user.calcDisplayname().trim().split(' ').first,
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .color
                      .withOpacity(0.66),
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
