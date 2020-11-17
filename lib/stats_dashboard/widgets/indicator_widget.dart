import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class IndicatorWidget extends StatelessWidget {
  final String color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const IndicatorWidget({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 12,
    this.textColor = const Color(0xff505050),
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
            width: size,
            height: size,
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
            style: TextStyle(
                fontSize: 12,  color: textColor),
          )
        ],
      ),
    );
  }
}
