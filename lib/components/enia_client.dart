import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:fluffychat/utils/famedlysdk_store.dart';
import 'package:http/http.dart' as http;

class EniaClient {
  Future getFrequentMessagesInfo(String getFrequentMessagesHttp) async {
    final response = await http.get(getFrequentMessagesHttp);

    if (response.statusCode == 200) {
      var _source = Utf8Decoder().convert(response.bodyBytes);

      List frequentMessageInfo = frequentMessagesInfoFromJson(_source);

      await Store()
          .setItem('frequentMessagesInfo', jsonEncode(frequentMessageInfo));
    }
    return null;
  }
}

List<FrequentMessagesInfo> frequentMessagesInfoFromJson(String str) =>
    List<FrequentMessagesInfo>.from(
        json.decode(str).map((x) => FrequentMessagesInfo.fromJson(x)));

String frequentMessagesInfoToJson(List<FrequentMessagesInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FrequentMessagesInfo {
  FrequentMessagesInfo({
    this.tags,
    this.content,
  });

  String tags;
  String content;

  factory FrequentMessagesInfo.fromJson(Map<String, dynamic> json) =>
      FrequentMessagesInfo(
        tags: json['tags'],
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        'tags': tags,
        'content': content,
      };
}
