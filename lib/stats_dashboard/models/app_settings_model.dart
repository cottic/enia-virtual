// To parse this JSON data, do
//
//     final dashboard = dashboardFromJson(jsonString);

import 'dart:convert';

Dashboard dashboardFromJson(String str) => Dashboard.fromJson(json.decode(str));

String dashboardToJson(Dashboard data) => json.encode(data.toJson());

class Dashboard {
  Dashboard({
    this.name,
    this.apiBaseUrl,
    this.mediaBaseUrl,
    this.version,
    this.boards,
  });

  String name;
  String apiBaseUrl;
  String mediaBaseUrl;
  int version;
  List<Board> boards;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        name: json['name'],
        apiBaseUrl: json['api_base_url'],
        mediaBaseUrl: json['media_base_url'],
        version: json['version'],
        boards: List<Board>.from(json['boards'].map((x) => Board.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'api_base_url': apiBaseUrl,
        'media_base_url': mediaBaseUrl,
        'version': version,
        'boards': List<dynamic>.from(boards.map((x) => x.toJson())),
      };
}

class Board {
  Board({
    this.name,
    this.description,
    this.template,
    this.filter,
    this.charts,
  });

  String name;
  String description;
  String template;
  bool filter;
  List<Chart> charts;

  factory Board.fromJson(Map<String, dynamic> json) => Board(
        name: json['name'],
        description: json['description'],
        template: json['template'],
        filter: json['filter'],
        charts: List<Chart>.from(json['charts'].map((x) => Chart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'template': template,
        'filter': filter,
        'charts': List<dynamic>.from(charts.map((x) => x.toJson())),
      };
}

class Chart {
  Chart({
    this.title,
    this.type,
    this.description,
    this.apiUrl,
    this.mediaUrl,
  });

  String title;
  String type;
  String description;
  String apiUrl;
  String mediaUrl;

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        title: json['title'],
        type: json['type'],
        description: json['description'],
        apiUrl: json['api_url'],
        // ignore: prefer_if_null_operators
        mediaUrl: json['media_url'] == null ? null : json['media_url'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'type': type,
        'description': description,
        'api_url': apiUrl,
        // ignore: prefer_if_null_operators
        'media_url': mediaUrl == null ? null : mediaUrl,
      };
}
