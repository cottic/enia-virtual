import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter_matrix_html/flutter_html.dart';
import 'package:flutter/material.dart';
import '../utils/url_launcher.dart';

import 'matrix.dart';

class HtmlMessage extends StatelessWidget {
  final String html;
  final int maxLines;
  final Room room;
  final TextStyle defaultTextStyle;
  final TextStyle linkStyle;
  final double emoteSize;

  const HtmlMessage(
      {this.html,
      this.maxLines,
      this.room,
      this.defaultTextStyle,
      this.linkStyle,
      this.emoteSize});

  @override
  Widget build(BuildContext context) {
    // riot-web is notorious for creating bad reply fallback events from invalid messages which, if
    // not handled properly, can lead to impersination. As such, we strip the entire `<mx-reply>` tags
    // here already, to prevent that from happening.
    // We do *not* do this in an AST and just with simple regex here, as riot-web tends to create
    // miss-matching tags, and this way we actually correctly identify what we want to strip and, well,
    // strip it.
    final renderHtml = html.replaceAll(RegExp('<mx-reply>.*<\/mx-reply>'), '');

    // there is no need to pre-validate the html, as we validate it while rendering

    final themeData = Theme.of(context);
    return Html(
      data: renderHtml,
      defaultTextStyle: defaultTextStyle,
      emoteSize: emoteSize,
      linkStyle: linkStyle ??
          themeData.textTheme.bodyText2.copyWith(
            color: themeData.accentColor,
            decoration: TextDecoration.underline,
          ),
      shrinkToFit: true,
      maxLines: maxLines,
      onLinkTap: (url) => UrlLauncher(context, url).launchUrl(),
      onPillTap: (url) => UrlLauncher(context, url).launchUrl(),
      getMxcUrl: (String mxc, double width, double height) {
        final ratio = MediaQuery.of(context).devicePixelRatio;
        return Uri.parse(mxc)?.getThumbnail(
          Matrix.of(context).client,
          width: (width ?? 800) * ratio,
          height: (height ?? 800) * ratio,
          method: ThumbnailMethod.scale,
        );
      },
      getPillInfo: (String identifier) async {
        if (room == null) {
          return null;
        }
        if (identifier[0] == '@') {
          // we have a user pill
          final user = room.getState('m.room.member', identifier);
          if (user != null) {
            return user.content;
          }
          // there might still be a profile...
          final profile = await room.client.getProfileFromUserId(identifier);
          if (profile != null) {
            return {
              'displayname': profile.displayname,
              'avatar_url': profile.avatarUrl.toString(),
            };
          }
          return null;
        }
        if (identifier[0] == '#') {
          // we have an alias pill
          for (final r in room.client.rooms) {
            final state = r.getState('m.room.canonical_alias');
            if (state != null &&
                ((state.content['alias'] is String &&
                        state.content['alias'] == identifier) ||
                    (state.content['alt_aliases'] is List &&
                        state.content['alt_aliases'].contains(identifier)))) {
              // we have a room!
              return {
                'displayname': identifier,
                'avatar_url': r.getState('m.room.avatar')?.content['url'],
              };
            }
          }
          return null;
        }
        if (identifier[0] == '!') {
          // we have a room ID pill
          final r = room.client.getRoomById(identifier);
          if (r == null) {
            return null;
          }
          return {
            'displayname': r.canonicalAlias,
            'avatar_url': r.getState('m.room.avatar')?.content['url'],
          };
        }
        return null;
      },
    );
  }
}
