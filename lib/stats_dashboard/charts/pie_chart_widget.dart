import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import '../widgets/indicator_widget.dart';
import '../models/pie_chart_model.dart';

class PieChartWidget extends StatefulWidget {
  PieChartWidget({@required this.apiUrl});

  final String apiUrl;

  @override
  State<StatefulWidget> createState() => PieChartState();
}

class PieChartState extends State<PieChartWidget> {
  PieChartInfo pieChartInfo;
  List<IndicatorWidget> indicators = [];
  List<PieChartSectionData> pieDataList = [];
  int touchedIndex;

  Future<PieChartInfo> loadChartFromApi() async {
    var barChartInfoJson = await rootBundle.loadString(widget.apiUrl);

    pieChartInfo = pieChartInfoFromJson(barChartInfoJson);

    indicators = pieChartInfo.indicatorsList;

    for (var pieChartSection in pieChartInfo.pieChartSections) {
      final title = pieChartSection.title;
      final value = pieChartSection.value;
      final color = pieChartSection.color;

      final pieChartSectionWidget = PieChartSectionData(
        color: HexColor(color),
        value: value,
        title: title,
      );
      pieDataList.add(pieChartSectionWidget);
    }
    // await Future.delayed(Duration(seconds: 3));
    return pieChartInfo;
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> pieDatainter = [];
    for (var i = 0; i < pieDataList.length; i++) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 130.0 : 80.0;
      pieDatainter.add(
        PieChartSectionData(
          color: pieDataList[i].color,
          value: pieDataList[i].value,
          title: pieDataList[i].title,
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: pieDataList[i].titleStyle.fontWeight,
              color: pieDataList[i].titleStyle.color),
        ),
      );
    }
    return pieDatainter;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadChartFromApi(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Text(L10n.of(context).noInternet),
            );
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
              return Center(
                child: Text(L10n.of(context).somethingWrong),
              );
            } else {
              if (snapshot.data != null) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 190.0,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse.touchInput
                                        is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  touchedIndex = -1;
                                } else {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                }
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 20,
                          centerSpaceRadius: 16,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: indicators,
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
