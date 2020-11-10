import 'dart:convert';

import 'package:fluffychat/stats_dashboard/models/app_settings_model.dart';
import 'package:fluffychat/stats_dashboard/widgets/card_chart_holder.dart';
import 'package:fluffychat/stats_dashboard/widgets/header_dashboard_widget.dart';
import 'package:fluffychat/stats_dashboard/charts/pie_chart_widget.dart';
import 'package:flutter/material.dart';

import 'package:fluffychat/stats_dashboard/charts/bar_chart_widget.dart';
import 'package:fluffychat/stats_dashboard/charts/card_chart_widget.dart';
import 'package:fluffychat/stats_dashboard/dashboard_menu_items.dart';
import 'package:fluffychat/stats_dashboard/charts/line_chart_widget.dart';
import 'package:flutter/services.dart';

import '../components/adaptive_page_layout.dart';
import '../components/dialogs/simple_dialogs.dart';
import '../components/matrix.dart';
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

  Future<Board> loadConfigJson() async {
    var appSetingsJson = await rootBundle.loadString('app_settings.json');

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
                  child: Text('Please connect to inernet an try again'));
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
                //TODO: internazionalizar texto
                return Center(child: Text('Algo salio mal //'));
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
                        CardChartHolder(
                          title: cardChart.title,
                          description: cardChart.description,
                          icon: Icons.accessibility_new,
                          dataWidget: CardEniaStats(
                            apiUrl: cardChart.apiUrl,
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
                                BarChartWidget(
                                  apiUrl: barChart.apiUrl,
                                ),
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
                                        child: LineChartWidget(
                                          apiUrl: lineChart.apiUrl,
                                        ),
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
                                      PieChartWidget(
                                        apiUrl: pieChart.apiUrl,
                                      ),
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
                          //TODO: internazionalizar texto
                          Text('Algo salio mal, vuelva a intentarlo mas tarde'),
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
