import 'dart:convert';

import 'package:fluffychat/stats_dashboard/models/app_settings_model.dart';
import 'package:fluffychat/stats_dashboard/widgets/drop_down_filter_list.dart';
import 'package:fluffychat/stats_dashboard/widgets/filter_stats_widget.dart';
import 'package:fluffychat/stats_dashboard/widgets/header_dashboard_widget.dart';
import 'package:flutter/material.dart';

import 'package:fluffychat/stats_dashboard/dashboard_menu_items.dart';
import 'package:flutter/services.dart';

import '../components/adaptive_page_layout.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'constants_dashboard.dart';
import 'models/drop_down_item_model.dart';

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

  Chart pieSingleChart = Chart();

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

    // await Future.delayed(Duration(seconds: 3));

    board = dashboard.boards[1];
    cardChart = dashboard.boards[1].charts[0];
    barChart = dashboard.boards[1].charts[1];
    lineChart = dashboard.boards[1].charts[2];
    pieChart = dashboard.boards[1].charts[3];

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
                        /* Row(
                          children: [
                            CardChartHolder(
                              title: cardChart.title,
                              description: cardChart.description,
                              icon: Icons.accessibility_new,
                              chartUrl: cardChart.apiUrl +
                                  initialDateFilter +
                                  endDateFilter +
                                  provinciaFilter,
                              color: true,
                            ),
                            CardChartHolder(
                              title: cardChart.title,
                              description: cardChart.description,
                              icon: Icons.accessibility_new,
                              chartUrl: cardChart.apiUrl +
                                  initialDateFilter +
                                  endDateFilter +
                                  provinciaFilter,
                              color: false,
                            ),
                            CardChartHolder(
                              title: cardChart.title,
                              description: cardChart.description,
                              icon: Icons.accessibility_new,
                              chartUrl: cardChart.apiUrl +
                                  initialDateFilter +
                                  endDateFilter +
                                  provinciaFilter,
                              color: true,
                            ),
                            CardChartHolder(
                              title: cardChart.title,
                              description: cardChart.description,
                              icon: Icons.accessibility_new,
                              chartUrl: cardChart.apiUrl +
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
                                            style: mainTitleCharts,
                                          ),
                                        ),
                                        BarChartWidget(
                                          apiUrl: barChart.apiUrl +
                                              initialDateFilter +
                                              endDateFilter +
                                              provinciaFilter,
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
                                          pieSingleChart.title,
                                          style: mainTitleCharts,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          pieChart.title,
                                          style: mainTitleCharts,
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
                                        ),
                                        Center(
                                          child: LineChartWidget(
                                            apiUrl: lineChart.apiUrl +
                                                initialDateFilter +
                                                endDateFilter +
                                                provinciaFilter,
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
                        ), */
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
