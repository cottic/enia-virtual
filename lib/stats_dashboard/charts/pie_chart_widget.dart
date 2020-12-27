import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import '../widgets/indicator_widget.dart';
import 'package:fluffychat/stats_dashboard/services/dashboard_services.dart';
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
  int dataLeng;
  DashboardService service = DashboardService();

  Future<PieChartInfo> loadChartFromApi() async {
    var pieChartInfoJson = await service.loadChartFromApi(widget.apiUrl);

    pieChartInfo = pieChartInfoFromJson(pieChartInfoJson);

    indicators = pieChartInfo.indicatorsList;

    dataLeng = pieChartInfo.pieChartSections.length;

    if (indicators.isEmpty) {
      pieChartInfo = null;
    } else {
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
    }
    return pieChartInfo;
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      dataLeng,
      (i) {
        final isTouched = i == touchedIndex;
        // ignore: omit_local_variable_types
        final double fontSize = isTouched ? 18 : 16;
        // if you dont declare, it fails
        // ignore: omit_local_variable_types
        final double radius = isTouched ? 96 : 90;
        // if you dont declare, it fails
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: pieDataList[0].color,
              value: pieDataList[0].value,
              title: pieDataList[0].value.toString() + '%',
              radius: radius,
              badgeWidget: isTouched
                  ? PieBadge(
                      value: pieDataList[0].title,
                      borderColor: pieDataList[0].color,
                    )
                  : Container(),
              badgePositionPercentageOffset: 1.4,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: pieDataList[0].titleStyle.fontWeight,
                  color: pieDataList[0].titleStyle.color),
            );
          case 1:
            return PieChartSectionData(
              color: pieDataList[1].color,
              value: pieDataList[1].value,
              title: pieDataList[1].value.toString() + '%',
              radius: radius,
              badgeWidget: isTouched
                  ? PieBadge(
                      value: pieDataList[1].title,
                      borderColor: pieDataList[1].color,
                    )
                  : Container(),
              badgePositionPercentageOffset: 1.4,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: pieDataList[1].titleStyle.fontWeight,
                  color: pieDataList[1].titleStyle.color),
            );
          case 2:
            if (pieDataList.length > 2) {
              return PieChartSectionData(
                color: pieDataList[2].color,
                value: pieDataList[2].value,
                title: pieDataList[2].value.toString() + '%',
                radius: radius,
                badgeWidget: isTouched
                    ? PieBadge(
                        value: pieDataList[2].title,
                        borderColor: pieDataList[2].color,
                      )
                    : Container(),
                badgePositionPercentageOffset: 1.4,
                titleStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: pieDataList[2].titleStyle.fontWeight,
                    color: pieDataList[2].titleStyle.color),
              );
            }
            return null;
          case 3:
            if (pieDataList.length > 3) {
              return PieChartSectionData(
                color: pieDataList[3].color,
                value: pieDataList[3].value,
                title: pieDataList[3].value.toString() + '%',
                radius: radius,
                badgeWidget: isTouched
                    ? PieBadge(
                        value: pieDataList[3].title,
                        borderColor: pieDataList[3].color,
                      )
                    : Container(),
                badgePositionPercentageOffset: 1.4,
                titleStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: pieDataList[3].titleStyle.fontWeight,
                    color: pieDataList[3].titleStyle.color),
              );
            }
            return null;

          case 4:
            if (pieDataList.length > 4) {
              return PieChartSectionData(
                color: pieDataList[4].color,
                value: pieDataList[4].value,
                title: pieDataList[4].value.toString() + '%',
                radius: radius,
                badgeWidget: isTouched
                    ? PieBadge(
                        value: pieDataList[4].title,
                        borderColor: pieDataList[4].color,
                      )
                    : Container(),
                badgePositionPercentageOffset: 1.4,
                titleStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: pieDataList[4].titleStyle.fontWeight,
                    color: pieDataList[4].titleStyle.color),
              );
            }
            return null;
          case 5:
            if (pieDataList.length > 5) {
              return PieChartSectionData(
                color: pieDataList[5].color,
                value: pieDataList[5].value,
                title: pieDataList[5].value.toString() + '%',
                radius: radius,
                badgeWidget: isTouched
                    ? PieBadge(
                        value: pieDataList[5].title,
                        borderColor: pieDataList[5].color,
                      )
                    : Container(),
                badgePositionPercentageOffset: 1.4,
                titleStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: pieDataList[5].titleStyle.fontWeight,
                    color: pieDataList[5].titleStyle.color),
              );
            }
            return null;
          case 6:
            if (pieDataList.length > 6) {
              return PieChartSectionData(
                color: pieDataList[6].color,
                value: pieDataList[6].value,
                title: pieDataList[6].value.toString() + '%',
                radius: radius,
                badgeWidget: isTouched
                    ? PieBadge(
                        value: pieDataList[6].title,
                        borderColor: pieDataList[6].color,
                      )
                    : Container(),
                badgePositionPercentageOffset: 1.4,
                titleStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: pieDataList[6].titleStyle.fontWeight,
                    color: pieDataList[6].titleStyle.color),
              );
            }
            return null;
          default:
            return null;
        }
      },
    );
  }

  /*   List<PieChartSectionData> showingSections() {


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
  } */

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
                          pieTouchData:
                              PieTouchData(touchCallback: (pieTouchResponse) {
                            setState(() {
                              touchedIndex =
                                  pieTouchResponse.touchedSectionIndex;
                              /* if (pieTouchResponse.touchInput
                                      is FlLongPressEnd ||
                                  pieTouchResponse.touchInput is FlPanEnd) {
                                touchedIndex = -1;
                              } else {
                                touchedIndex =
                                    pieTouchResponse.touchedSectionIndex;
                              } */
                            });
                          }),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 20,
                          centerSpaceRadius: 0,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 30,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: indicators,
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text(L10n.of(context).noInfoAvailable),
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

class PieBadge extends StatelessWidget {
  final String value;
  final Color borderColor;

  const PieBadge({@required this.borderColor, this.value});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      constraints: BoxConstraints(
        maxHeight: 26,
        maxWidth: 60,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(0),
      child: Center(
        child: Text(value),
      ),
    );
  }
}
