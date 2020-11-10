import 'dart:convert';

import 'package:fluffychat/stats_dashboard/stats_dashboard_01.dart';
import 'package:fluffychat/utils/app_route.dart';
import 'package:fluffychat/views/chat_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'models/app_settings_model.dart';
import 'widgets/dashboard_menu_item_widget.dart';
import 'stats_dashboard_02.dart';

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
    var appSetingsJson = await rootBundle.loadString('app_settings.json');

    Map appSettingsMap = await jsonDecode(appSetingsJson);

    dashboard = Dashboard.fromJson(appSettingsMap);

    return dashboard;
  }

  @override
  Widget build(BuildContext context) {
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
            'Estadisticas',
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
                //TODO: internazionalizar texto
                return Center(child: Text('Algo salio mal //'));
              } else {
                if (snapshot.data != null) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Seleccionar Tablero:',
                                style: Theme.of(context).textTheme.subtitle1,
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
                          ],
                        ),
                      ),
                      FlatButton.icon(
                        padding: EdgeInsets.all(20),
                        label: Text(
                          'VOLVER',
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
                      //TODO: internazionalizar texto
                      Text('Algo salio mal, vuelva a intentarlo mas tarde'),
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
