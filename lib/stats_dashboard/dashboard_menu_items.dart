import 'dart:convert';

import 'package:fluffychat/stats_dashboard/dashboard_01.dart';
import 'package:fluffychat/utils/app_route.dart';
import 'package:fluffychat/views/chat_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'models/app_settings_model.dart';
import 'widgets/dashboard_menu_item_widget.dart';
import 'dashboard_02.dart';
import 'dashboard_03.dart';
import 'dashboard_04.dart';
import 'dashboard_05.dart';
import 'dashboard_06.dart';
import 'dashboard_07.dart';
import 'dashboard_08.dart';
import 'dashboard_09.dart';
import 'dashboard_10.dart';

class DashboardMainMenu extends StatefulWidget {
  @override
  _DashboardMainMenuState createState() => _DashboardMainMenuState();
}

class _DashboardMainMenuState extends State<DashboardMainMenu> {
  Dashboard dashboard = Dashboard();

  void _drawerTapAction(Widget view) {
    Navigator.of(context).pop();
    Navigator.of(context).pushAndRemoveUntil(
      AppRoute.defaultRoute(
        context,
        view,
      ),
      (r) => r.isFirst,
    );
  }

  Future<Dashboard> loadConfigJson() async {
    var appSetingsJson =
        await rootBundle.loadString('assets/app_settings.json');

    Map appSettingsMap = await jsonDecode(appSetingsJson);

    dashboard = Dashboard.fromJson(appSettingsMap);

    return dashboard;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = false;
    if (MediaQuery.of(context).size.width <= 1000) {
      screenSize = false;
    } else {
      screenSize = true;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0.0,
        leading: Container(
          padding: EdgeInsets.all(6),
          color: Color(0XFFf5f5f5),
          child: Image.asset(
            'assets/logo.png',
          ),
        ),
        titleSpacing: 0,
        title: Container(
          width: double.maxFinite,
          height: 54,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20),
          color: Theme.of(context).primaryColor,
          child: Text(
            L10n.of(context).stats,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Theme.of(context).backgroundColor),
          ),
        ),
      ),
      backgroundColor: Color(0XFFf5f5f5),
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
                    children: [
                      screenSize
                          ? Expanded(
                              child: ListView(
                                children: [
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      L10n.of(context).selectDashboard,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                  DashboardMenuItem(
                                    title: dashboard.boards[0].name,
                                    subTitle: dashboard.boards[0].description,
                                    onTap: () => _drawerTapAction(
                                      StatsEniaMenu01View(),
                                    ),
                                  ),
                                  DashboardMenuItem(
                                    title: dashboard.boards[1].name,
                                    subTitle: dashboard.boards[1].description,
                                    onTap: () => _drawerTapAction(
                                      StatsEniaMenu02View(),
                                    ),
                                  ),
                                  DashboardMenuItem(
                                    title: dashboard.boards[2].name,
                                    subTitle: dashboard.boards[2].description,
                                    onTap: () => _drawerTapAction(
                                      StatsEniaMenu03View(),
                                    ),
                                  ),
                                  DashboardMenuItem(
                                    title: dashboard.boards[3].name,
                                    subTitle: dashboard.boards[3].description,
                                    onTap: () => _drawerTapAction(
                                      StatsEniaMenu04View(),
                                    ),
                                  ),
                                  DashboardMenuItem(
                                    title: dashboard.boards[4].name,
                                    subTitle: dashboard.boards[4].description,
                                    onTap: () => _drawerTapAction(
                                      StatsEniaMenu05View(),
                                    ),
                                  ),
                                  DashboardMenuItem(
                                    title: dashboard.boards[5].name,
                                    subTitle: dashboard.boards[5].description,
                                    onTap: () => _drawerTapAction(
                                      StatsEniaMenu06View(),
                                    ),
                                  ),
                                  DashboardMenuItem(
                                    title: dashboard.boards[6].name,
                                    subTitle: dashboard.boards[6].description,
                                    onTap: () => _drawerTapAction(
                                      StatsEniaMenu07View(),
                                    ),
                                  ),
                                  DashboardMenuItem(
                                    title: dashboard.boards[7].name,
                                    subTitle: dashboard.boards[7].description,
                                    onTap: () => _drawerTapAction(
                                      StatsEniaMenu08View(),
                                    ),
                                  ),
                                  DashboardMenuItem(
                                    title: dashboard.boards[8].name,
                                    subTitle: dashboard.boards[8].description,
                                    onTap: () => _drawerTapAction(
                                      StatsEniaMenu09View(),
                                    ),
                                  ),
                                  DashboardMenuItem(
                                    title: dashboard.boards[9].name,
                                    subTitle: dashboard.boards[9].description,
                                    onTap: () => _drawerTapAction(
                                      StatsEniaMenu10View(),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: Center(
                                  child: Text(L10n.of(context).resolutionIncompatible)),
                            ),
                      FlatButton.icon(
                        padding: EdgeInsets.all(20),
                        label: Text(
                          L10n.of(context).goBack,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        icon: FaIcon(
                          FontAwesomeIcons.arrowCircleLeft,
                          color: Theme.of(context).primaryColor,
                          size: 26,
                        ),
                        onPressed: () => _drawerTapAction(
                          ChatListView(),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        size: 50,
                      ),
                      SizedBox(height: 20.0),
                      Text(L10n.of(context).somethingWrong),
                    ],
                  );
                }
              }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
