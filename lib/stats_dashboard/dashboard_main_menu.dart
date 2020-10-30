import 'package:fluffychat/utils/app_route.dart';
import 'package:fluffychat/views/chat_list.dart';
import 'package:fluffychat/views/stats_enia_menu_01.dart';
import 'package:fluffychat/views/stats_enia_menu_02.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dashboard_menu_item_widget.dart';

class DashboardMainMenu extends StatefulWidget {
  @override
  _DashboardMainMenuState createState() => _DashboardMainMenuState();
}

class _DashboardMainMenuState extends State<DashboardMainMenu> {
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
            )),
      ),
      backgroundColor: Color(0XFFf5f5f5),
      body: Column(
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
                  title: 'SSyR: Salud Sexual y Reproductivo',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual y Reproductiva	',
                  onTap: () => _drawerTapAction(
                    StatsEniaMenu01View(),
                  ),
                ),
                DashboardMenuItem(
                  title: 'SSyR: Salud Sexual 2',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual 2	',
                  onTap: () => _drawerTapAction(
                    StatsEniaMenu02View(),
                  ),
                ),
                DashboardMenuItem(
                  title: 'SSyR: Salud Sexual y Reproductivo',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual y Reproductiva	',
                  onTap: () => _drawerTapAction(
                    StatsEniaMenu01View(),
                  ),
                ),
                DashboardMenuItem(
                  title: 'SSyR: Salud Sexual 2',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual 2	',
                  onTap: () => _drawerTapAction(
                    StatsEniaMenu02View(),
                  ),
                ),
                DashboardMenuItem(
                  title: 'SSyR: Salud Sexual y Reproductivo',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual y Reproductiva	',
                  onTap: () => _drawerTapAction(
                    StatsEniaMenu01View(),
                  ),
                ),
                DashboardMenuItem(
                  title: 'SSyR: Salud Sexual 2',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual 2	',
                  onTap: () => _drawerTapAction(
                    StatsEniaMenu02View(),
                  ),
                ),
                DashboardMenuItem(
                  title: 'SSyR: Salud Sexual y Reproductivo',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual y Reproductiva	',
                  onTap: () => _drawerTapAction(
                    StatsEniaMenu01View(),
                  ),
                ),
                DashboardMenuItem(
                  title: 'SSyR: Salud Sexual 2',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual 2	',
                  onTap: () => _drawerTapAction(
                    StatsEniaMenu02View(),
                  ),
                ),
                DashboardMenuItem(
                  title: 'SSyR: Salud Sexual y Reproductivo',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual y Reproductiva	',
                  onTap: () => _drawerTapAction(
                    StatsEniaMenu01View(),
                  ),
                ),
                DashboardMenuItem(
                  title: 'SSyR: Salud Sexual 2',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual 2	',
                  onTap: () => _drawerTapAction(
                    StatsEniaMenu02View(),
                  ),
                ),
                DashboardMenuItem(
                  title: 'SSyR: Salud Sexual y Reproductivo',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual y Reproductiva	',
                  onTap: () => _drawerTapAction(
                    StatsEniaMenu01View(),
                  ),
                ),
                DashboardMenuItem(
                  title: 'SSyR: Salud Sexual 2',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual 2	',
                  onTap: () => _drawerTapAction(
                    StatsEniaMenu02View(),
                  ),
                ),
                DashboardMenuItem(
                  title: 'SSyR: Salud Sexual y Reproductivo',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual y Reproductiva	',
                  onTap: () => _drawerTapAction(
                    StatsEniaMenu01View(),
                  ),
                ),
                DashboardMenuItem(
                  title: 'SSyR: Salud Sexual 2',
                  subTitle:
                      'Tablero de la direccion de Salud Sexual 2	',
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
      ),
    );
  }
}

