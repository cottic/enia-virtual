import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  static const double barWidth = 22;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        // XXXXXX VAR GRAFICO XXXXXX
        // El numero maximo del grafico eje Y
        maxY: 10000,
        // XXXXXX VAR GRAFICO XXXXXX
        // El numero minimo del grafico eje Y
        minY: 0,
        // distancia entre barras
        groupsSpace: 20,
        barTouchData: BarTouchData(
          enabled: true,
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(color: Colors.orange, fontSize: 10),
            margin: 10,
            rotateAngle: 0,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return '2018';
                case 1:
                  return '2019';
                case 2:
                  return '2020';
                default:
                  return '';
              }
            },
          ),
          bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(color: Colors.red, fontSize: 10),
            margin: 10,
            rotateAngle: 0,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return '2018';
                case 1:
                  return '2019';
                case 2:
                  return '2020';

                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(color: Colors.red, fontSize: 10),
            rotateAngle: 45,
            getTitles: (double value) {
              //print('value');
              //print(value);

              if (value == 0) {
                return '0';
              }
              return '${value.toInt()}00 LARCs';
            },
            interval: 1000,
            margin: 8,
            reservedSize: 30,
          ),
          rightTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(color: Colors.blue, fontSize: 10),
            rotateAngle: 0,
            getTitles: (double value) {
              if (value == 0) {
                return '0';
              }
              return '${value.toInt()}00 LARCs';
            },
            interval: 3000,
            margin: 8,
            reservedSize: 30,
          ),
        ),
        gridData: FlGridData(
          show: true,
          checkToShowHorizontalLine: (value) => value % 1000 == 0,
          getDrawingHorizontalLine: (value) {
            if (value == 0) {
              return FlLine(color: const Color(0xff363753), strokeWidth: 3);
            }
            return FlLine(
              color: const Color(0xff2a2747),
              strokeWidth: 0.8,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                y: 4816,
                width: barWidth,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                rodStackItems: [
                  BarChartRodStackItem(0, 1200, const Color(0xffff4d94)),
                  BarChartRodStackItem(1200, 4816, const Color(0xff19bfff)),
                ],
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                y: 7820,
                width: barWidth,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                rodStackItems: [
                  BarChartRodStackItem(0, 3200, const Color(0xffff4d94)),
                  BarChartRodStackItem(3200, 7820, const Color(0xff19bfff)),
                ],
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                y: 1258,
                width: barWidth,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                rodStackItems: [
                  BarChartRodStackItem(0, 600, const Color(0xffff4d94)),
                  BarChartRodStackItem(600, 1258, const Color(0xff19bfff)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
