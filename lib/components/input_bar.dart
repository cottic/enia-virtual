import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'avatar.dart';

class InputBar extends StatelessWidget {
  final Room room;
  final int minLines;
  final int maxLines;
  final TextInputType keyboardType;
  final ValueChanged<String> onSubmitted;
  final FocusNode focusNode;
  final TextEditingController controller;
  final InputDecoration decoration;
  final ValueChanged<String> onChanged;

  InputBar({
    this.room,
    this.minLines,
    this.maxLines,
    this.keyboardType,
    this.onSubmitted,
    this.focusNode,
    this.controller,
    this.decoration,
    this.onChanged,
  });

  List<Map<String, String>> getSuggestions(String text) {
    if (controller.selection.baseOffset != controller.selection.extentOffset ||
        controller.selection.baseOffset < 0) {
      return []; // no entries if there is selected text
    }
    final searchText =
        controller.text.substring(0, controller.selection.baseOffset);
    final ret = <Map<String, String>>[];
    final emojiMatch =
        RegExp(r'(?:\s|^):(?:([-\w]+)~)?([-\w]+)$').firstMatch(searchText);
    final MAX_RESULTS = 10;
    if (emojiMatch != null) {
      final packSearch = emojiMatch[1];
      final emoteSearch = emojiMatch[2].toLowerCase();
      final emotePacks = room.emotePacks;
      if (packSearch == null || packSearch.isEmpty) {
        for (final pack in emotePacks.entries) {
          for (final emote in pack.value.entries) {
            if (emote.key.toLowerCase().contains(emoteSearch)) {
              ret.add({
                'type': 'emote',
                'name': emote.key,
                'pack': pack.key,
                'mxc': emote.value,
              });
            }
            if (ret.length > MAX_RESULTS) {
              break;
            }
          }
          if (ret.length > MAX_RESULTS) {
            break;
          }
        }
      } else if (emotePacks[packSearch] != null) {
        for (final emote in emotePacks[packSearch].entries) {
          if (emote.key.toLowerCase().contains(emoteSearch)) {
            ret.add({
              'type': 'emote',
              'name': emote.key,
              'pack': packSearch,
              'mxc': emote.value,
            });
          }
          if (ret.length > MAX_RESULTS) {
            break;
          }
        }
      }
    }
    final userMatch = RegExp(r'(?:\s|^)@([-\w]+)$').firstMatch(searchText);
    if (userMatch != null) {
      final userSearch = userMatch[1].toLowerCase();
      for (final user in room.getParticipants()) {
        if ((user.displayName != null &&
                user.displayName.toLowerCase().contains(userSearch)) ||
            user.id.split(':')[0].toLowerCase().contains(userSearch)) {
          ret.add({
            'type': 'user',
            'mxid': user.id,
            'displayname': user.displayName,
            'avatar_url': user.avatarUrl?.toString(),
          });
        }
        if (ret.length > MAX_RESULTS) {
          break;
        }
      }
    }
    final roomMatch = RegExp(r'(?:\s|^)#([-\w]+)$').firstMatch(searchText);
    if (roomMatch != null) {
      final roomSearch = roomMatch[1].toLowerCase();
      for (final r in room.client.rooms) {
        final state = r.getState('m.room.canonical_alias');
        if (state != null &&
            ((state.content['alias'] is String &&
                    state.content['alias']
                        .split(':')[0]
                        .toLowerCase()
                        .contains(roomSearch)) ||
                (state.content['alt_aliases'] is List &&
                    state.content['alt_aliases'].any((l) =>
                        l is String &&
                        l.split(':')[0].toLowerCase().contains(roomSearch))) ||
                (room.name != null &&
                    room.name.toLowerCase().contains(roomSearch)))) {
          ret.add({
            'type': 'room',
            'mxid': (r.canonicalAlias != null && r.canonicalAlias.isNotEmpty)
                ? r.canonicalAlias
                : r.id,
            'displayname': r.displayname,
            'avatar_url': r.avatar?.toString(),
          });
        }
        if (ret.length > MAX_RESULTS) {
          break;
        }
      }
    }
    return ret;
  }

  Widget buildSuggestion(BuildContext context, Map<String, String> suggestion) {
    if (suggestion['type'] == 'emote') {
      final size = 30.0;
      final ratio = MediaQuery.of(context).devicePixelRatio;
      final url = Uri.parse(suggestion['mxc'] ?? '')?.getThumbnail(
        room.client,
        width: size * ratio,
        height: size * ratio,
        method: ThumbnailMethod.scale,
      );
      return Container(
        padding: EdgeInsets.all(4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AdvancedNetworkImage(url, useDiskCache: !kIsWeb),
              width: size,
              height: size,
            ),
            SizedBox(width: 6),
            Text(suggestion['name']),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Opacity(
                  opacity: 0.5,
                  child: Text(suggestion['pack']),
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (suggestion['type'] == 'user' || suggestion['type'] == 'room') {
      final size = 30.0;
      final url = Uri.parse(suggestion['avatar_url'] ?? '');
      return Container(
        padding: EdgeInsets.all(4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Avatar(url, suggestion['displayname'] ?? suggestion['mxid'],
                size: size),
            SizedBox(width: 6),
            Text(suggestion['displayname'] ?? suggestion['mxid']),
          ],
        ),
      );
    }
    return Container();
  }

  void insertSuggestion(BuildContext context, Map<String, String> suggestion) {
    final replaceText =
        controller.text.substring(0, controller.selection.baseOffset);
    var startText = '';
    final afterText = replaceText == controller.text
        ? ''
        : controller.text.substring(controller.selection.baseOffset + 1);
    var insertText = '';
    if (suggestion['type'] == 'emote') {
      var isUnique = true;
      final insertEmote = suggestion['name'];
      final insertPack = suggestion['pack'];
      final emotePacks = room.emotePacks;
      for (final pack in emotePacks.entries) {
        if (pack.key == insertPack) {
          continue;
        }
        for (final emote in pack.value.entries) {
          if (emote.key == insertEmote) {
            isUnique = false;
            break;
          }
        }
        if (!isUnique) {
          break;
        }
      }
      insertText = (isUnique
              ? insertEmote
              : ':${insertPack}~${insertEmote.substring(1)}') +
          ' ';
      startText = replaceText.replaceAllMapped(
        RegExp(r'(\s|^)(:(?:[-\w]+~)?[-\w]+)$'),
        (Match m) => '${m[1]}${insertText}',
      );
    }
    if (suggestion['type'] == 'user') {
      insertText = suggestion['mxid'] + ' ';
      startText = replaceText.replaceAllMapped(
        RegExp(r'(\s|^)(@[-\w]+)$'),
        (Match m) => '${m[1]}${insertText}',
      );
    }
    if (suggestion['type'] == 'room') {
      insertText = suggestion['mxid'] + ' ';
      startText = replaceText.replaceAllMapped(
        RegExp(r'(\s|^)(#[-\w]+)$'),
        (Match m) => '${m[1]}${insertText}',
      );
    }
    if (insertText.isNotEmpty && startText.isNotEmpty) {
      controller.text = startText + afterText;
      if (startText == insertText) {
        // stupid fix for now
        FocusScope.of(context).requestFocus(FocusNode());
        Future.delayed(Duration(milliseconds: 1)).then((res) {
          focusNode.requestFocus();
          controller.selection = TextSelection(
            baseOffset: startText.length,
            extentOffset: startText.length,
          );
        });
      } else {
        controller.selection = TextSelection(
          baseOffset: startText.length,
          extentOffset: startText.length,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Map<String, String>>(
      direction: AxisDirection.up,
      hideOnEmpty: true,
      hideOnLoading: true,
      keepSuggestionsOnSuggestionSelected: true,
      debounceDuration: Duration(
          milliseconds:
              50), // show suggestions after 50ms idle time (default is 300)
      textFieldConfiguration: TextFieldConfiguration(
        minLines: minLines,
        maxLines: maxLines,
        keyboardType: keyboardType,
        onSubmitted: (text) {
          // fix for library for now
          onSubmitted(text);
        },
        focusNode: focusNode,
        controller: controller,
        decoration: decoration,
        onChanged: (text) {
          onChanged(text);
        },
        textCapitalization: TextCapitalization.sentences,
      ),
      suggestionsCallback: getSuggestions,
      itemBuilder: buildSuggestion,
      onSuggestionSelected: (Map<String, String> suggestion) =>
          insertSuggestion(context, suggestion),
      errorBuilder: (BuildContext context, Object error) => Container(),
      loadingBuilder: (BuildContext context) =>
          Container(), // fix loading briefly flickering a dark box
      noItemsFoundBuilder: (BuildContext context) =>
          Container(), // fix loading briefly showing no suggestions
    );
  }
}
