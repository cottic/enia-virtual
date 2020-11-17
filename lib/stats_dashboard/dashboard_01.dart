import 'dart:convert';

import 'package:fluffychat/stats_dashboard/models/app_settings_model.dart';
import 'package:fluffychat/stats_dashboard/widgets/card_chart_holder.dart';
import 'package:fluffychat/stats_dashboard/widgets/header_dashboard_widget.dart';
import 'package:fluffychat/stats_dashboard/charts/pie_chart_widget.dart';
import 'package:flutter/material.dart';

import 'package:fluffychat/stats_dashboard/charts/bar_chart_widget.dart';
import 'package:fluffychat/stats_dashboard/dashboard_menu_items.dart';
import 'package:fluffychat/stats_dashboard/charts/line_chart_widget.dart';
import 'package:flutter/services.dart';

import '../components/adaptive_page_layout.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'models/bar_chart_model.dart';

class StatsEniaMenu01View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.SECOND,
      firstScaffold: DashboardMainMenu(),
      secondScaffold: StatsEniaMenu01(),
    );
  }
}

class StatsEniaMenu01 extends StatefulWidget {
  @override
  _StatsEniaMenu01State createState() => _StatsEniaMenu01State();
}

class _StatsEniaMenu01State extends State<StatsEniaMenu01> {
  Board board = Board();

  Chart cardChart = Chart();
  Chart barChart = Chart();
  Chart lineChart = Chart();
  Chart pieChart = Chart();

  BarChartInfo barChartInfo = BarChartInfo();

  List barCharts;
  List indicators;

  TextStyle titleCharts =
      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600);

  TextStyle descriptionCharts = TextStyle(fontSize: 10.0, color: Colors.grey);

  Future<Board> loadConfigJson() async {
    var appSetingsJson =
        await rootBundle.loadString('assets/app_settings.json');

    Map appSettingsMap = await jsonDecode(appSetingsJson);

    var dashboard = await Dashboard.fromJson(appSettingsMap);

    board = dashboard.boards[0];
    cardChart = dashboard.boards[0].charts[0];
    barChart = dashboard.boards[0].charts[1];
    lineChart = dashboard.boards[0].charts[2];
    pieChart = dashboard.boards[0].charts[3];

    return board;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadConfigJson(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text(L10n.of(context).noInternet),
              );
            case ConnectionState.waiting:
              return Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case ConnectionState.active:
              return Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text(L10n.of(context).somethingWrong),
                );
              } else {
                if (snapshot.data != null) {
                  return NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) =>
                            <Widget>[
                      HeaderUniqueDashboard(
                        title: board.name,
                      ),
                    ],
                    body: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 50.0,
                          ),
                          child: Text(board.description),
                        ),
                        Row(
                          children: [
                            CardChartHolder(
                              title: cardChart.title,
                              description: cardChart.description,
                              icon: Icons.accessibility_new,
                              chartUrl: cardChart.apiUrl,
                              color: true,
                            ),
                            CardChartHolder(
                              title: cardChart.title,
                              description: cardChart.description,
                              icon: Icons.accessibility_new,
                              chartUrl: cardChart.apiUrl,
                              color: false,
                            ),
                            CardChartHolder(
                              title: cardChart.title,
                              description: cardChart.description,
                              icon: Icons.accessibility_new,
                              chartUrl: cardChart.apiUrl,
                              color: true,
                            ),
                            CardChartHolder(
                              title: cardChart.title,
                              description: cardChart.description,
                              icon: Icons.accessibility_new,
                              chartUrl: cardChart.apiUrl,
                              color: true,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 400,
                                child: Card(
                                  margin: EdgeInsets.all(10.0),
                                  elevation: 3.0,
                                  color: Color(0XFFF9F9F9),
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: Text(
                                            barChart.title,
                                            overflow: TextOverflow.ellipsis,
                                            style: titleCharts,
                                          ),
                                        ),
                                        BarChartWidget(
                                          apiUrl: barChart.apiUrl,
                                          height: 240.0,
                                        ),
                                        Text(
                                          barChart.description,
                                          style: descriptionCharts,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 400,
                                child: Card(
                                  margin: EdgeInsets.all(10.0),
                                  elevation: 3.0,
                                  color: Color(0XFFF9F9F9),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          pieChart.title,
                                          style: titleCharts,
                                        ),
                                        PieChartWidget(
                                          apiUrl: pieChart.apiUrl,
                                        ),
                                        Text(
                                          pieChart.description,
                                          style: descriptionCharts,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 400,
                                child: Card(
                                  margin: EdgeInsets.all(10.0),
                                  elevation: 3.0,
                                  color: Color(0XFFF9F9F9),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          pieChart.title,
                                          style: titleCharts,
                                        ),
                                        PieChartWidget(
                                          apiUrl: pieChart.apiUrl,
                                        ),
                                        Text(
                                          pieChart.description,
                                          style: descriptionCharts,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 400,
                                child: Card(
                                  margin: EdgeInsets.all(10.0),
                                  elevation: 3.0,
                                  color: Color(0XFFF9F9F9),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lineChart.title,
                                          style: titleCharts,
                                        ),
                                        Center(
                                          child: LineChartWidget(
                                            apiUrl: lineChart.apiUrl,
                                          ),
                                        ),
                                        Text(
                                          lineChart.description,
                                          style: descriptionCharts,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.error,
                            size: 50,
                          ),
                          SizedBox(height: 20.0),
                          Text(L10n.of(context).somethingWrong),
                        ],
                      ),
                    ),
                  );
                }
              }
          }
          return Center(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
