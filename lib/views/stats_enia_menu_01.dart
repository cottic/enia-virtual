import 'package:fluffychat/stats_dashboard/header_dashboard_widget.dart';
import 'package:fluffychat/stats_dashboard/pie_chart_widget.dart';
import 'package:flutter/material.dart';

import 'package:fluffychat/stats_dashboard/bar_chart_widget.dart';
import 'package:fluffychat/stats_dashboard/card_enia_stats_widget.dart';
import 'package:fluffychat/stats_dashboard/dashboard_main_menu.dart';
import 'package:fluffychat/stats_dashboard/line_chart_widget.dart';

import '../components/adaptive_page_layout.dart';
import '../components/dialogs/simple_dialogs.dart';
import '../components/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';



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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            <Widget>[
          HeaderUniqueDashboard(
            title: 'SSyR: Salud Sexual y Reproductivo',
          ),
        ],
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                  'Tablero de la direccion de Salud Sexual y Reproductiva	'),
            ),
            SizedBox(
              height: 20,
            ),
            CardEniaStats(
              title: 'Total de LARCS',
              subTitle: 'Total de LARCS.',
              data: '8902',
              icon: Icons.accessibility_new,
            ),
            Card(
              color: Color(0XFFF9F9F9),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      title:
                          Text('Dispensa de LARCs - Población objetivo plan'),
                      subtitle: Text(
                          'El modelo de estimación de metas de impacto o MEMI establece como población objetivo un 75% de mujeres sexualmente activas de 10 a 19 años en los 36 departamentos. '
                          'De este total, un 75% se estima cubrir con LARCs (70% con implantes, 5% con DIU); un total de 176.335 adolescentes a cubrir con LARCs en el período 2018-2019'),
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
                            title: Text(
                                'Evolución mensual de la dispensa de LARCs'),
                            subtitle: Text(
                                'Durante 2019, el comportamiento de la dispensa reportada se estabiliza en 2.700 LARCs promedio mensual'),
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
                            title:
                                Text('Larcs estimados y dispensados por año'),
                            subtitle: Text(
                                'Considerando la población estimada a cubrir con LARCs para el 2020, a abril  2020 se alcanza un 10% de lo esperado. El desempeño para 2018 y 2019 estuvo en torno al 33% y 39% respectivamente. '),
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
      ),
    );
  }
}
