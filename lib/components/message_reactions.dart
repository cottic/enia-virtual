import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

import 'matrix.dart';

class MessageReactions extends StatelessWidget {
  final Event event;
  final Timeline timeline;

  const MessageReactions(this.event, this.timeline);

  @override
  Widget build(BuildContext context) {
    final allReactionEvents =
        event.aggregatedEvents(timeline, RelationshipTypes.Reaction);
    final reactionMap = <String, _ReactionEntry>{};
    for (final e in allReactionEvents) {
      if (e.content['m.relates_to'].containsKey('key')) {
        final key = e.content['m.relates_to']['key'];
        if (!reactionMap.containsKey(key)) {
          reactionMap[key] = _ReactionEntry(
            key: key,
            count: 0,
            reacted: false,
          );
        }
        reactionMap[key].count++;
        reactionMap[key].reacted |= e.senderId == e.room.client.userID;
      }
    }
    final reactionList = reactionMap.values.toList();
    reactionList.sort((a, b) => b.count - a.count > 0 ? 1 : -1);
    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: reactionList
          .map((r) => _Reaction(
                reactionKey: r.key,
                count: r.count,
                reacted: r.reacted,
                onTap: () {
                  if (r.reacted) {
                    final evt = allReactionEvents.firstWhere(
                        (e) =>
                            e.senderId == e.room.client.userID &&
                            e.content['m.relates_to']['key'] == r.key,
                        orElse: () => null);
                    if (evt != null) {
                      evt.redact();
                    }
                  } else {
                    event.room.sendReaction(event.eventId, r.key);
                  }
                },
              ))
          .toList(),
    );
  }
}

class _Reaction extends StatelessWidget {
  final String reactionKey;
  final int count;
  final bool reacted;
  final void Function() onTap;

  const _Reaction({this.reactionKey, this.count, this.reacted, this.onTap});

  @override
  Widget build(BuildContext context) {
    final borderColor = reacted ? Colors.red : Theme.of(context).primaryColor;
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    final color = Theme.of(context).secondaryHeaderColor;
    final fontSize = DefaultTextStyle.of(context).style.fontSize;
    final padding = fontSize / 5;
    Widget content;
    if (reactionKey.startsWith('mxc://')) {
      final src = Uri.parse(reactionKey)?.getThumbnail(
        Matrix.of(context).client,
        width: 9999,
        height: fontSize * MediaQuery.of(context).devicePixelRatio,
        method: ThumbnailMethod.scale,
      );
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image(
            image: AdvancedNetworkImage(
              src,
              useDiskCache: !kIsWeb,
            ),
            height: fontSize,
          ),
          Text(count.toString(),
              style: TextStyle(
                color: textColor,
                fontSize: DefaultTextStyle.of(context).style.fontSize,
              )),
        ],
      );
    } else {
      var renderKey = reactionKey;
      if (renderKey.length > 10) {
        renderKey = renderKey.substring(0, 7) + '...';
      }
      content = Text('$renderKey $count',
          style: TextStyle(
            color: textColor,
            fontSize: DefaultTextStyle.of(context).style.fontSize,
          ));
    }
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            width: fontSize / 20,
            color: borderColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(padding * 2)),
        ),
        padding: EdgeInsets.all(padding),
        child: content,
      ),
      onTap: () => onTap != null ? onTap() : null,
    );
  }
}

class _ReactionEntry {
  String key;
  int count;
  bool reacted;

  _ReactionEntry({this.key, this.count, this.reacted});
}
