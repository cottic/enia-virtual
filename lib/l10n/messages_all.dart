// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that looks up messages for specific locales by
// delegating to the appropriate library.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:implementation_imports, file_names, unnecessary_new
// ignore_for_file:unnecessary_brace_in_string_interps, directives_ordering
// ignore_for_file:argument_type_not_assignable, invalid_assignment
// ignore_for_file:prefer_single_quotes, prefer_generic_function_type_aliases
// ignore_for_file:comment_references

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';

import 'messages_cs.dart' as messages_cs;
import 'messages_de.dart' as messages_de;
import 'messages_es.dart' as messages_es;
import 'messages_fr.dart' as messages_fr;
import 'messages_gl.dart' as messages_gl;
import 'messages_hr.dart' as messages_hr;
import 'messages_hu.dart' as messages_hu;
import 'messages_hy.dart' as messages_hy;
import 'messages_ja.dart' as messages_ja;
import 'messages_messages.dart' as messages_messages;
import 'messages_pl.dart' as messages_pl;
import 'messages_ru.dart' as messages_ru;
import 'messages_sk.dart' as messages_sk;
import 'messages_tr.dart' as messages_tr;
import 'messages_uk.dart' as messages_uk;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
  'cs': () => new Future.value(null),
  'de': () => new Future.value(null),
  'es': () => new Future.value(null),
  'fr': () => new Future.value(null),
  'gl': () => new Future.value(null),
  'hr': () => new Future.value(null),
  'hu': () => new Future.value(null),
  'hy': () => new Future.value(null),
  'ja': () => new Future.value(null),
  'messages': () => new Future.value(null),
  'pl': () => new Future.value(null),
  'ru': () => new Future.value(null),
  'sk': () => new Future.value(null),
  'tr': () => new Future.value(null),
  'uk': () => new Future.value(null),
};

MessageLookupByLibrary _findExact(String localeName) {
  switch (localeName) {
    case 'cs':
      return messages_cs.messages;
    case 'de':
      return messages_de.messages;
    case 'es':
      return messages_es.messages;
    case 'fr':
      return messages_fr.messages;
    case 'gl':
      return messages_gl.messages;
    case 'hr':
      return messages_hr.messages;
    case 'hu':
      return messages_hu.messages;
    case 'hy':
      return messages_hy.messages;
    case 'ja':
      return messages_ja.messages;
    case 'messages':
      return messages_messages.messages;
    case 'pl':
      return messages_pl.messages;
    case 'ru':
      return messages_ru.messages;
    case 'sk':
      return messages_sk.messages;
    case 'tr':
      return messages_tr.messages;
    case 'uk':
      return messages_uk.messages;
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName, (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return new Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? new Future.value(false) : lib());
  initializeInternalMessageLookup(() => new CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  return new Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(String locale) {
  var actualLocale =
      Intl.verifiedLocale(locale, _messagesExistFor, onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
