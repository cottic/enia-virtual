import 'dart:convert';

import 'package:fluffychat/stats_dashboard/models/app_settings_model.dart';
import 'package:fluffychat/stats_dashboard/widgets/card_chart_holder.dart';
import 'package:fluffychat/stats_dashboard/widgets/drop_down_filter_list.dart';
import 'package:fluffychat/stats_dashboard/widgets/header_dashboard_widget.dart';
import 'package:fluffychat/stats_dashboard/charts/pie_chart_widget.dart';
import 'package:flutter/material.dart';

import 'package:fluffychat/stats_dashboard/charts/bar_chart_widget.dart';
import 'package:fluffychat/stats_dashboard/dashboard_menu_items.dart';
import 'package:fluffychat/stats_dashboard/charts/line_chart_widget.dart';
import 'package:flutter/services.dart';

import '../components/adaptive_page_layout.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'charts/pie_sinlge_chart_widget.dart';
import 'constants_dashboard.dart';
import 'models/bar_chart_model.dart';
import 'models/drop_down_item_model.dart';
import 'widgets/filter_stats_widget.dart';

class StatsEniaMenu06View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.SECOND,
      firstScaffold: DashboardMainMenu(),
      secondScaffold: StatsEniaMenu06(),
    );
  }
}

class StatsEniaMenu06 extends StatefulWidget {
  @override
  _StatsEniaMenu06State createState() => _StatsEniaMenu06State();
}

class _StatsEniaMenu06State extends State<StatsEniaMenu06> {
  Board board = Board();

  Chart cardChart0 = Chart();
  Chart cardChart1 = Chart();
  Chart cardChart2 = Chart();
  Chart cardChart3 = Chart();

  Chart barChart = Chart();
  Chart lineChart = Chart();
  Chart pieChart = Chart();
  Chart pieSingleChart = Chart();

  BarChartInfo barChartInfo = BarChartInfo();

  List barCharts;
  List indicators;

  String initialDateFilter = '';
  DateTime initialSelectedDate;
  bool initialSelected = false;

  String endDateFilter = '';
  DateTime endSelectedDate;
  bool endSelected = false;

  String provinciaFilter = '';

  DropDownItemsModel _selectedItem;

  Future<Board> loadConfigJson() async {
    var appSetingsJson =
        await rootBundle.loadString('assets/app_settings.json');

    Map appSettingsMap = await jsonDecode(appSetingsJson);

    var dashboard = await Dashboard.fromJson(appSettingsMap);

    board = dashboard.boards[5];
    cardChart0 = dashboard.boards[5].charts[0];
    cardChart1 = dashboard.boards[5].charts[1];
    cardChart2 = dashboard.boards[5].charts[2];
    cardChart3 = dashboard.boards[5].charts[3];
    barChart = dashboard.boards[5].charts[4];
    pieSingleChart = dashboard.boards[5].charts[5];
    pieChart = dashboard.boards[5].charts[6];
    lineChart = dashboard.boards[5].charts[7];

    return board;
  }

  List<DropdownMenuItem<DropDownItemsModel>> _dropdownMenuItems;

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(dropdownItems);
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
                        dateFromString: initialSelected
                            ? '${initialSelectedDate.toLocal()}'.substring(0, 7)
                            : 'Desde',
                        onPressDateFrom: () {
                          showMonthPicker(
                            context: context,
                            firstDate: DateTime(2014),
                            lastDate: endSelectedDate ?? DateTime.now(),
                            initialDate: DateTime(2019),
                          ).then((date) {
                            if (date != null) {
                              setState(() {
                                initialSelected = true;
                                initialSelectedDate = date;
                                initialDateFilter = '&desde=${date.year}';
                              });
                            }
                          });
                        },
                        dateToString: endSelected
                            ? '${endSelectedDate.toLocal()}'.substring(0, 7)
                            : 'Hasta',
                        onPressDateTo: () {
                          showMonthPicker(
                            context: context,
                            firstDate: initialSelectedDate ?? DateTime(2014),
                            lastDate: DateTime.now(),
                            initialDate: DateTime.now(),
                          ).then((date) {
                            if (date != null) {
                              setState(() {
                                endSelected = true;
                                endSelectedDate = date;
                                endDateFilter =
                                    '&hasta=' '${date.month}' '${date.year}';
                              });
                            }
                          });
                        },
                        filterDropDown: DropdownButton(
                          isExpanded: true,
                          value: _selectedItem,
                          style: dropDownitem,
                          items: _dropdownMenuItems,
                          hint: Text(
                            'Todas',
                            style: dropDownitem,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedItem = value;
                              provinciaFilter =
                                  getProvinciaValue(_selectedItem.value);
                            });
                          },
                        ),
                      ),
                    ],
                    body: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          child: Text(
                            board.description,
                            style: headerMain.copyWith(fontSize: 16.0),
                          ),
                        ),
                        Row(
                          children: [
                            CardChartHolder(
                              title: cardChart0.title,
                              description: cardChart0.description,
                              icon: cardChart0.mediaUrl,
                              chartUrl: cardChart0.apiUrl +
                                  initialDateFilter +
                                  endDateFilter +
                                  provinciaFilter,
                              color: true,
                            ),
                            CardChartHolder(
                              title: cardChart1.title,
                              description: cardChart1.description,
                              icon: cardChart1.mediaUrl,
                              chartUrl: cardChart1.apiUrl +
                                  initialDateFilter +
                                  endDateFilter +
                                  provinciaFilter,
                              color: false,
                            ),
                            CardChartHolder(
                              title: cardChart2.title,
                              description: cardChart2.description,
                              icon: cardChart2.mediaUrl,
                              chartUrl: cardChart2.apiUrl +
                                  initialDateFilter +
                                  endDateFilter +
                                  provinciaFilter,
                              color: true,
                            ),
                            CardChartHolder(
                              title: cardChart3.title,
                              description: cardChart3.description,
                              icon: cardChart3.mediaUrl,
                              chartUrl: cardChart3.apiUrl +
                                  initialDateFilter +
                                  endDateFilter +
                                  provinciaFilter,
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
                                            maxLines: 1,
                                            style: mainTitleCharts,
                                          ),
                                        ),
                                        BarChartWidget(
                                          apiUrl: barChart.apiUrl +
                                              initialDateFilter +
                                              endDateFilter +
                                              provinciaFilter,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          //height: 50,
                                          width: double.infinity,
                                          child: Text(
                                            pieSingleChart.title,
                                            style: mainTitleCharts,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        PieSingleChartWidget(
                                          apiUrl: pieSingleChart.apiUrl +
                                              initialDateFilter +
                                              endDateFilter +
                                              provinciaFilter,
                                        ),
                                        Text(
                                          pieSingleChart.description,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            pieChart.title,
                                            style: mainTitleCharts,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        PieChartWidget(
                                          apiUrl: pieChart.apiUrl +
                                              initialDateFilter +
                                              endDateFilter +
                                              provinciaFilter,
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
                                          style: mainTitleCharts,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        LineChartWidget(
                                          apiUrl: lineChart.apiUrl +
                                              initialDateFilter +
                                              endDateFilter +
                                              provinciaFilter,
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
