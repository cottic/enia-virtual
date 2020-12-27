import 'dart:convert';

import '../widgets/indicator_widget.dart';

BarChartInfo barChartInfoFromJson(String str) =>
    BarChartInfo.fromJson(json.decode(str));

String barChartInfoToJson(BarChartInfo data) => json.encode(data.toJson());

class BarChartInfo {
  BarChartInfo({
    this.maxNumberY,
    this.minNumberY,
    this.listTitlesX,
    this.titlesYright,
    this.intervalY,
    this.backLinesDividedByMaxNumberY,
    this.indicators,
    this.barChartList,
  });

  double maxNumberY;
  double minNumberY;
  List<String> listTitlesX;
  String titlesYright;
  double intervalY;
  double backLinesDividedByMaxNumberY;
  List<IndicatorWidget> indicators;
  List<BarChartList> barChartList;

  factory BarChartInfo.fromJson(Map<String, dynamic> json) => BarChartInfo(
        maxNumberY: json['maxNumberY'],
        minNumberY: json['minNumberY'],
        listTitlesX: List<String>.from(json['listTitlesX'].map((x) => x)),
        titlesYright: json['titlesYright'],
        intervalY: json['intervalY'],
        backLinesDividedByMaxNumberY: json['backLinesDividedByMaxNumberY'],
        indicators: List<IndicatorWidget>.from(
            json['indicators'].map((x) => IndicatorWidget.fromJson(x))),
        barChartList: List<BarChartList>.from(
            json['barChartList'].map((x) => BarChartList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'maxNumberY': maxNumberY,
        'minNumberY': minNumberY,
        'listTitlesX': List<dynamic>.from(listTitlesX.map((x) => x)),
        'titlesYright': titlesYright,
        'intervalY': intervalY,
        'backLinesDividedByMaxNumberY': backLinesDividedByMaxNumberY,
        'barChartList': List<dynamic>.from(barChartList.map((x) => x.toJson())),
      };
}

class BarChartList {
  BarChartList({
    this.x,
    this.barRods,
  });

  int x;
  List<BarRod> barRods;

  factory BarChartList.fromJson(Map<String, dynamic> json) => BarChartList(
        x: json['x'],
        barRods:
            List<BarRod>.from(json['barRods'].map((x) => BarRod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'x': x,
        'barRods': List<dynamic>.from(barRods.map((x) => x.toJson())),
      };
}

class BarRod {
  BarRod({
    this.totalY,
    this.barChartRoddData,
  });

  double totalY;
  List<BarChartRoddDatum> barChartRoddData;

  factory BarRod.fromJson(Map<String, dynamic> json) => BarRod(
        totalY: json['totalY'],
        barChartRoddData: List<BarChartRoddDatum>.from(
            json['barChartRoddData'].map((x) => BarChartRoddDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'totalY': totalY,
        'barChartRoddData':
            List<dynamic>.from(barChartRoddData.map((x) => x.toJson())),
      };
}

class BarChartRoddDatum {
  BarChartRoddDatum({
    this.start,
    this.end,
    this.color,
  });

  double start;
  double end;
  String color;

  factory BarChartRoddDatum.fromJson(Map<String, dynamic> json) =>
      BarChartRoddDatum(
        start: json['start'],
        end: json['end'],
        color: json['color'],
      );

  Map<String, dynamic> toJson() => {
        'start': start,
        'end': end,
        'color': color,
      };
}
