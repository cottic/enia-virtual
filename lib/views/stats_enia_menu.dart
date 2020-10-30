
import 'package:flutter/material.dart';

import '../components/adaptive_page_layout.dart';
import '../components/dialogs/simple_dialogs.dart';
import '../components/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:fluffychat/stats_dashboard/dashboard_main_menu.dart';


class StatsEniaMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.SECOND,
      firstScaffold: DashboardMainMenu(),
      secondScaffold: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('DASHBOARD ESTADISTICAS', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline4,),
            SizedBox(height: 40,),
            Image.asset('assets/logo.png', width: 100, height: 100),
          ],
        ),
      ),
    );
  }
}
