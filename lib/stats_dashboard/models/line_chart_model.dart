import 'dart:convert';

import '../widgets/indicator_widget.dart';

LineChartInfo lineChartInfoFromJson(String str) =>
    LineChartInfo.fromJson(json.decode(str));

String lineChartInfoToJson(LineChartInfo data) => json.encode(data.toJson());

class LineChartInfo {
  LineChartInfo({
    this.listTitlesX,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
    this.titlesYright,
    this.intervalY,
    this.backLinesDividedByMaxNumberY,
    this.indicatorsList,
    this.lineBarsData,
  });

  List<String> listTitlesX;
  double minX;
  double maxX;
  double minY;
  double maxY;
  String titlesYright;
  double intervalY;
  double backLinesDividedByMaxNumberY;
  List<IndicatorWidget> indicatorsList;
  List<LineBarsDatum> lineBarsData;

  factory LineChartInfo.fromJson(Map<String, dynamic> json) => LineChartInfo(
        listTitlesX: List<String>.from(json['listTitlesX'].map((x) => x)),
        minX: json['minX'],
        maxX: json['maxX'],
        minY: json['minY'],
        maxY: json['maxY'],
        titlesYright: json['titlesYright'],
        intervalY: json['intervalY'],
        backLinesDividedByMaxNumberY: json['backLinesDividedByMaxNumberY'],
        indicatorsList: List<IndicatorWidget>.from(
            json['indicatorsList'].map((x) => IndicatorWidget.fromJson(x))),
        lineBarsData: List<LineBarsDatum>.from(
            json['lineBarsData'].map((x) => LineBarsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'listTitlesX': List<dynamic>.from(listTitlesX.map((x) => x)),
        'minX': minX,
        'maxX': maxX,
        'minY': minY,
        'maxY': maxY,
        'titlesYright': titlesYright,
        'intervalY': intervalY,
        'backLinesDividedByMaxNumberY': backLinesDividedByMaxNumberY,
        'lineBarsData': List<dynamic>.from(lineBarsData.map((x) => x.toJson())),
      };
}

class LineBarsDatum {
  LineBarsDatum({
    this.isCurved,
    this.color,
    this.spots,
  });

  bool isCurved;
  String color;
  List<Spot> spots;

  factory LineBarsDatum.fromJson(Map<String, dynamic> json) => LineBarsDatum(
        isCurved: json['isCurved'],
        color: json['color'],
        spots: List<Spot>.from(json['spots'].map((x) => Spot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'isCurved': isCurved,
        'color': color,
        'spots': List<dynamic>.from(spots.map((x) => x.toJson())),
      };
}

class Spot {
  Spot({
    this.spotPosition,
    this.spotNumber,
  });

  double spotPosition;
  double spotNumber;

  factory Spot.fromJson(Map<String, dynamic> json) => Spot(
        spotPosition: json['spotPosition'],
        spotNumber: json['spotNumber'],
      );

  Map<String, dynamic> toJson() => {
        'spotPosition': spotPosition,
        'spotNumber': spotNumber,
      };
}
