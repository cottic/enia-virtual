import 'dart:convert';

import 'package:fluffychat/stats_dashboard/models/app_settings_model.dart';
import 'package:fluffychat/stats_dashboard/widgets/header_dashboard_widget.dart';
import 'package:fluffychat/stats_dashboard/charts/pie_chart_widget.dart';
import 'package:flutter/material.dart';

import 'package:fluffychat/stats_dashboard/charts/bar_chart_widget.dart';
import 'package:fluffychat/stats_dashboard/charts/card_chart_widget.dart';
import 'package:fluffychat/stats_dashboard/dashboard_menu_items.dart';
import 'package:fluffychat/stats_dashboard/charts/line_chart_widget.dart';
import 'package:flutter/services.dart';

import '../components/adaptive_page_layout.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class StatsEniaMenu02View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.SECOND,
      firstScaffold: DashboardMainMenu(),
      secondScaffold: StatsEniaMenu02(),
    );
  }
}

class StatsEniaMenu02 extends StatefulWidget {
  @override
  _StatsEniaMenu02State createState() => _StatsEniaMenu02State();
}

class _StatsEniaMenu02State extends State<StatsEniaMenu02> {
  Board board = Board();

  Chart cardChart = Chart();
  Chart barChart = Chart();
  Chart lineChart = Chart();
  Chart pieChart = Chart();

  Future<Board> loadConfigJson() async {
    var appSetingsJson =
        await rootBundle.loadString('assets/app_settings.json');

    Map appSettingsMap = await jsonDecode(appSetingsJson);

    var dashboard = await Dashboard.fromJson(appSettingsMap);

    // await Future.delayed(Duration(seconds: 3));

    board = dashboard.boards[1];
    cardChart = dashboard.boards[1].charts[0];
    barChart = dashboard.boards[1].charts[1];
    lineChart = dashboard.boards[1].charts[2];
    pieChart = dashboard.boards[1].charts[3];

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
                return Center(child: Text(L10n.of(context).somethingWrong),);
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
                      children: <Widget>[
                        ListTile(
                          title: Text(board.description),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          color: Color(0XFFF9F9F9),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(cardChart.title),
                              subtitle: Text(cardChart.description),
                              trailing: Icon(Icons.accessibility_new,
                                  size: 50, color: Colors.green),
                              leading: CardEniaStats(
                                apiUrl: cardChart.apiUrl,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Color(0XFFF9F9F9),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(barChart.title),
                                  subtitle: Text(barChart.description),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                BarChartWidget(),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Card(
                                color: Color(0XFFF9F9F9),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(lineChart.title),
                                        subtitle: Text(lineChart.description),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: LineChartWidget(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                color: Color(0XFFF9F9F9),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(pieChart.title),
                                        subtitle: Text(pieChart.description),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      PieChartWidget(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
