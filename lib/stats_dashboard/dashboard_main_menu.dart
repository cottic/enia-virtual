import 'package:fluffychat/utils/app_route.dart';
import 'package:fluffychat/views/chat_list.dart';
import 'package:fluffychat/views/stats_enia_menu_01.dart';
import 'package:fluffychat/views/stats_enia_menu_02.dart';
import 'package:flutter/material.dart';

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
        //elevation: _scrolledToTop ? 0 : null,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => _drawerTapAction(
            ChatListView(),
          ),
        ),
        titleSpacing: 0,
        title: Text('Estadisticas Enia@virtual'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          ListTile(
            trailing: Icon(Icons.link),
            leading: Icon(Icons.bar_chart_outlined),
            //TODO: Esta info viene del YAML
            title: Text('SSyR: Salud Sexual y Reproductivo	'),
            subtitle:
                Text('Tablero de la direccion de Salud Sexual y Reproductiva	'),
            onTap: () => _drawerTapAction(
              StatsEniaMenu01View(),
            ),
          ),
          ListTile(
            trailing: Icon(Icons.link),
            leading: Icon(Icons.bar_chart_outlined),
            //TODO: Esta info viene del YAML
            title: Text('SSyR: Salud Sexual y Reproductivo	2'),
            subtitle:
                Text('Tablero de la direccion de Salud Sexual y Reproductiva	'),
            onTap: () => _drawerTapAction(
              //TODO: implementar ir pagina 2
              StatsEniaMenu02View(),
            ),
          ),
        ],
      ),
    );
  }
}