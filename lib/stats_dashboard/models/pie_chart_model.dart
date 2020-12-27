import 'dart:convert';

import '../widgets/indicator_widget.dart';

PieChartInfo pieChartInfoFromJson(String str) =>
    PieChartInfo.fromJson(json.decode(str));

class PieChartInfo {
  PieChartInfo({
    this.indicatorsList,
    this.pieChartSections,
  });

  List<IndicatorWidget> indicatorsList;
  List<PieChartSection> pieChartSections;

  factory PieChartInfo.fromJson(Map<String, dynamic> json) => PieChartInfo(
        indicatorsList: List<IndicatorWidget>.from(
            json['indicatorsList'].map((x) => IndicatorWidget.fromJson(x))),
        pieChartSections: List<PieChartSection>.from(
            json['pieChartSections'].map((x) => PieChartSection.fromJson(x))),
      );
}

class PieChartSection {
  PieChartSection({
    this.color,
    this.value,
    this.title,
  });

  String color;
  double value;
  String title;

  factory PieChartSection.fromJson(Map<String, dynamic> json) =>
      PieChartSection(
        color: json['color'],
        value: json['value'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'color': color,
        'value': value,
        'title': title,
      };
}
