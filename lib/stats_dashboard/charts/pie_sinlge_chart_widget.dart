import 'package:fl_chart/fl_chart.dart';
import 'package:fluffychat/stats_dashboard/models/pie_single_chart_model.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:fluffychat/stats_dashboard/services/dashboard_services.dart';

class PieSingleChartWidget extends StatefulWidget {
  PieSingleChartWidget({@required this.apiUrl});

  final String apiUrl;

  @override
  State<StatefulWidget> createState() => PieSingleChartState();
}

class PieSingleChartState extends State<PieSingleChartWidget> {
  int touchedIndex;

  PieSingleChartInfo pieSingleChartInfo = PieSingleChartInfo();

  Future<PieSingleChartInfo> loadChartFromApi() async {
    var pieSingleChartInfoJson =
        await DashboardService().loadChartFromApi(widget.apiUrl);

    pieSingleChartInfo = pieSingleChartInfoFromJson(pieSingleChartInfoJson);

    if (pieSingleChartInfo.pieSingleValue == '0') {
      pieSingleChartInfo = null;
    }

    return pieSingleChartInfo;
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      2,
      (i) {
        // ignore: omit_local_variable_types
        final double fontSize = 16;
        // if you dont declare, it fails
        // ignore: omit_local_variable_types
        final double radius = 50;
        // if you dont declare, it fails
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Theme.of(context).primaryColor,
              value: pieSingleChartInfo.pieSinglePorcentage,
              title: pieSingleChartInfo.pieSingleValue,
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 3,
                      offset: Offset(0, 0),
                    )
                  ],
                  color: Colors.white),
            );
          case 1:
            return PieChartSectionData(
              color: HexColor('#dbd0c9'),
              value: 100 - pieSingleChartInfo.pieSinglePorcentage,
              title: '',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            );

          default:
            return null;
        }
      },
    );
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
                      child: Stack(
                        children: [
                          PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                  touchCallback: (pieTouchResponse) {
                                /* setState(() {
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
                                }
                                ); */
                              }),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: 55,
                              sections: showingSections(),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${pieSingleChartInfo.pieSinglePorcentage}%',
                              style: TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
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
