import 'package:famedlysdk/famedlysdk.dart';
import 'package:famedlysdk/matrix_api.dart';
import 'package:fluffychat/components/dialogs/simple_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import '../../utils/app_route.dart';
import '../../views/chat.dart';
import '../avatar.dart';
import '../matrix.dart';

class PublicRoomListItem extends StatelessWidget {
  final PublicRoom publicRoomEntry;

  const PublicRoomListItem(this.publicRoomEntry, {Key key}) : super(key: key);

  void joinAction(BuildContext context) async {
    final success = await SimpleDialogs(context)
        .tryRequestWithLoadingDialog(_joinRoomAndWait(context));
    if (success != false) {
      await Navigator.of(context).push(
        AppRoute.defaultRoute(
          context,
          ChatView(success),
        ),
      );
    }
  }

  Future<String> _joinRoomAndWait(BuildContext context) async {
    final roomId =
        await Matrix.of(context).client.joinRoomOrAlias(publicRoomEntry.roomId);
    if (Matrix.of(context).client.getRoomById(roomId) == null) {
      await Matrix.of(context)
          .client
          .onRoomUpdate
          .stream
          .firstWhere((r) => r.id == roomId);
    }
    return roomId;
  }

  @override
  Widget build(BuildContext context) {
    final hasTopic =
        publicRoomEntry.topic != null && publicRoomEntry.topic.isNotEmpty;
    return ListTile(
      leading: Avatar(
          publicRoomEntry.avatarUrl == null
              ? null
              : Uri.parse(publicRoomEntry.avatarUrl),
          publicRoomEntry.name),
      title: Text(hasTopic
          ? '${publicRoomEntry.name} (${publicRoomEntry.numJoinedMembers})'
          : publicRoomEntry.name),
      subtitle: Text(
        hasTopic
            ? publicRoomEntry.topic
            : publicRoomEntry.numJoinedMembers == null
                ? L10n.of(context).joinRoom
                : L10n.of(context).countParticipants(
                    publicRoomEntry.numJoinedMembers.toString()),
        maxLines: 1,
      ),
      onTap: () => joinAction(context),
    );
  }
}
