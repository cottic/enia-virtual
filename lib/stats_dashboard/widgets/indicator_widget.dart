import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants_dashboard.dart';

class IndicatorWidget extends StatelessWidget {
  final String color;
  final String text;
  final bool isSquare;

  const IndicatorWidget({
    Key key,
    this.color,
    this.text,
    this.isSquare,
  }) : super(key: key);

  factory IndicatorWidget.fromJson(Map<String, dynamic> json) =>
      IndicatorWidget(
        color: json['color'],
        text: json['indicatorTitle'],
        isSquare: json['isSquare'],
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: indicatorsDotSize,
            height: indicatorsDotSize,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: HexColor(color),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            text,
            style: indicatorsText,
          )
        ],
      ),
    );
  }
}
