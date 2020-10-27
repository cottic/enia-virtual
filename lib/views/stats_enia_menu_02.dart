import 'package:fluffychat/stats_dashboard/pie_chart_widget.dart';
import 'package:flutter/material.dart';

import 'package:fluffychat/stats_dashboard/bar_chart_widget.dart';
import 'package:fluffychat/stats_dashboard/card_enia_stats_widget.dart';
import 'package:fluffychat/stats_dashboard/dashboard_main_menu.dart';
import 'package:fluffychat/stats_dashboard/filter_stats.dart';
import 'package:fluffychat/stats_dashboard/line_chart_widget.dart';
import 'package:fluffychat/utils/app_route.dart';

import '../components/adaptive_page_layout.dart';
import '../components/dialogs/simple_dialogs.dart';
import '../components/matrix.dart';
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
  Future<dynamic> profileFuture;
  dynamic profile;
  Future<bool> crossSigningCachedFuture;
  bool crossSigningCached;
  Future<bool> megolmBackupCachedFuture;
  bool megolmBackupCached;

  Future<void> requestSSSSCache(BuildContext context) async {
    final handle = Matrix.of(context).client.encryption.ssss.open();
    final str = await SimpleDialogs(context).enterText(
      titleText: L10n.of(context).askSSSSCache,
      hintText: L10n.of(context).passphraseOrKey,
      password: true,
    );
    if (str != null) {
      SimpleDialogs(context).showLoadingDialog(context);
      // make sure the loading spinner shows before we test the keys
      await Future.delayed(Duration(milliseconds: 100));
      var valid = false;
      try {
        handle.unlock(recoveryKey: str);
        valid = true;
      } catch (_) {
        try {
          handle.unlock(passphrase: str);
          valid = true;
        } catch (_) {
          valid = false;
        }
      }
      await Navigator.of(context)?.pop();
      if (valid) {
        await handle.maybeCacheAll();
        await SimpleDialogs(context).inform(
          contentText: L10n.of(context).cachedKeys,
        );
        setState(() {
          crossSigningCachedFuture = null;
          crossSigningCached = null;
          megolmBackupCachedFuture = null;
          megolmBackupCached = null;
        });
      } else {
        await SimpleDialogs(context).inform(
          contentText: L10n.of(context).incorrectPassphraseOrKey,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: true,
            pinned: true,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'SSyR: Salud 2',
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FiltersStats(),
                  ),
                ],
              ),
            ),
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
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CardEniaStats(
                    title: 'Total de LARCS',
                    subTitle: 'Total de LARCS.',
                    data: '8902',
                    icon: Icons.accessibility_new,
                  ),
                ),
              ],
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
                          LineChartWidget(),
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
