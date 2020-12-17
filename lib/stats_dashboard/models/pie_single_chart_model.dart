import 'dart:convert';

PieSingleChartInfo pieSingleChartInfoFromJson(String str) =>
    PieSingleChartInfo.fromJson(json.decode(str));

String pieSingleChartInfoToJson(PieSingleChartInfo data) =>
    json.encode(data.toJson());

class PieSingleChartInfo {
  PieSingleChartInfo({
    this.pieSinglePorcentage,
    this.pieSingleValue,
  });

  double pieSinglePorcentage;
  String pieSingleValue;

  factory PieSingleChartInfo.fromJson(Map<String, dynamic> json) =>
      PieSingleChartInfo(
        pieSinglePorcentage: json['pieSinglePorcentage'].toDouble(),
        pieSingleValue: json['pieSingleValue'],
      );

  Map<String, dynamic> toJson() => {
        'pieSinglePorcentage': pieSinglePorcentage,
        'pieSingleValue': pieSingleValue,
      };
}
