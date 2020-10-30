import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'pie_indicator_widget.dart';

class PieChartWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartState();
}

class PieChartState extends State {
  List<Indicator> indicatorList = [
    Indicator(
      color: Color(0xff0293ee),
      text: '2018',
      isSquare: false,
    ),
    Indicator(
      color: Color(0xfff8b250),
      text: '2019',
      isSquare: true,
    ),
    Indicator(
      color: Color(0xff845bef),
      text: '2020',
      isSquare: true,
    ),
  ];

  List<PieChartSectionData> pieDataList = [
    PieChartSectionData(
      color: const Color(0xff0293ee),
      value: 40,
      title: '2320',
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
    ),
    PieChartSectionData(
      color: Colors.red,
      value: 50,
      title: '4550',
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
    ),
    PieChartSectionData(
      color: Colors.amber,
      value: 10,
      title: '855',
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
    )
  ];

  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(
          height: 18,
        ),
        Expanded(
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  setState(() {
                    if (pieTouchResponse.touchInput is FlLongPressEnd ||
                        pieTouchResponse.touchInput is FlPanEnd) {
                      touchedIndex = -1;
                    } else {
                      touchedIndex = pieTouchResponse.touchedSectionIndex;
                    }
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 100,
                centerSpaceRadius: 16,
                sections: showingSections()),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: indicatorList,
        ),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> pieDatainter = [];
    for (var i = 0; i < pieDataList.length; i++) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 100.0 : 80.0;
      pieDatainter.add(PieChartSectionData(
        color: pieDataList[i].color,
        value: pieDataList[i].value,
        title: pieDataList[i].title,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: pieDataList[i].titleStyle.fontWeight,
            color: pieDataList[i].titleStyle.color),
      ));
    }
    return pieDatainter;
  }
}
