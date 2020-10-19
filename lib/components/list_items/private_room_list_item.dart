import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter/material.dart';

import '../../utils/app_route.dart';
import '../../views/chat.dart';
import '../avatar.dart';

class PrivateRoomListItem extends StatelessWidget {
  final Room roomEntry;

  const PrivateRoomListItem(this.roomEntry, {Key key}) : super(key: key);

  void joinAction(BuildContext context) async {
    var roomID = roomEntry.id;

    if (roomID != null) {
      await Navigator.of(context).push(
        AppRoute.defaultRoute(
          context,
          ChatView(roomID),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => joinAction(context),
      child: Container(
        width: 76,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              child: Avatar(
                  roomEntry.avatar == null
                      ? null
                      : Uri.parse(roomEntry.avatar.toString()),
                  roomEntry.name),
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
                roomEntry.displayname.trim().split(' ').first,
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
