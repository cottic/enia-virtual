import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:hexcolor/hexcolor.dart';

import '../models/bar_chart_model.dart';

class BarChartWidget extends StatefulWidget {
  BarChartWidget({@required this.apiUrl});

  final String apiUrl;

  @override
  _BarChartWidgetState createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  static const double barWidth = 22;

  BarChartInfo barChartInfo;

  List indicators;

  List barCharts;

  List<BarChartGroupData> barGroupsList = [];

  Future<BarChartInfo> loadChartFromApi() async {
    var barChartInfoJson = await rootBundle.loadString(widget.apiUrl);

    barChartInfo = barChartInfoFromJson(barChartInfoJson);

    if (barChartInfo.barChartList != null) {
      for (var barCharItem in barChartInfo.barChartList) {
        List<BarChartRodData> barGroupBars = [];

        for (var barRodItem in barCharItem.barRods) {
          List<BarChartRodStackItem> barSegmentsList = [];

          for (var barSegments in barRodItem.barChartRoddData) {
            final barSegment = BarChartRodStackItem(
              barSegments.start,
              barSegments.end,
              HexColor(barSegments.color),
            );

            barSegmentsList.add(barSegment);
          }

          final barItem = BarChartRodData(
            y: barRodItem.totalY,
            width: barWidth,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: barSegmentsList,
          );

          barGroupBars.add(barItem);
        }

        final barGroupItem = BarChartGroupData(
          x: barCharItem.x,
          barRods: barGroupBars,
        );

        barGroupsList.add(barGroupItem);
      }
    }

    indicators = barChartInfo.indicators;
    barCharts = barChartInfo.barChartList;

    return barChartInfo;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadChartFromApi(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
                child: Text('Please connect to inernet an try again'));
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              //TODO: internazionalizar texto
              return Center(child: Text('Algo salio mal //'));
            } else {
              if (snapshot.data != null) {
                return Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: indicators,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.center,
                        // XXXXXX VAR GRAFICO XXXXXX
                        // El numero maximo del grafico eje Y
                        maxY: barChartInfo.maxNumberY,
                        // XXXXXX VAR GRAFICO XXXXXX
                        // El numero minimo del grafico eje Y
                        minY: barChartInfo.minNumberY,
                        // distancia entre barras
                        groupsSpace: 20,
                        barTouchData: BarTouchData(
                          enabled: true,
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          // TITULO SUPERIOR
                          topTitles: SideTitles(
                            showTitles: false,
                          ),
                          // TITULOS IZQUIERDA
                          leftTitles: SideTitles(
                            showTitles: false,
                          ),
                          // TITULO INFERIOR
                          bottomTitles: SideTitles(
                            showTitles: true,
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 10),
                            margin: 10,
                            rotateAngle: 0,
                            getTitles: (double value) {
                              for (var i = 0;
                                  i < barChartInfo.listTitlesX.length;
                                  i++) {
                                return barChartInfo.listTitlesX[value.toInt()];
                              }
                              return '';
                            },
                          ),

                          // TITULOS DERECHA
                          rightTitles: SideTitles(
                            showTitles: true,
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 10),
                            rotateAngle: 0,
                            getTitles: (double value) {
                              if (value == 0) {
                                return '0';
                              }
                              return '${value.toInt()} ${barChartInfo.titlesYright.toString()}';
                            },
                            interval: barChartInfo.intervalY,
                            margin: 8,
                            reservedSize: 30,
                          ),
                        ),
                        // DATA SOBRE LA GRID (linead de atras en el grafico)
                        gridData: FlGridData(
                          show: true,
                          checkToShowHorizontalLine: (value) =>
                              value %
                                  barChartInfo.backLinesDividedByMaxNumberY ==
                              0,
                          getDrawingHorizontalLine: (value) {
                            if (value == 0) {
                              return FlLine(
                                  color: const Color(0xff363753),
                                  strokeWidth: 3);
                            }
                            return FlLine(
                              color: const Color(0xff2a2747),
                              strokeWidth: 0.8,
                            );
                          },
                        ),
                        // GRAFICO CON O SIN BORDE
                        borderData: FlBorderData(
                          show: true,
                        ),
                        //TODO: implementar esto
                        barGroups: barGroupsList,
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}