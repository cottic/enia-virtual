import 'package:flutter/material.dart';

import '../components/adaptive_page_layout.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:fluffychat/stats_dashboard/dashboard_menu_items.dart';

class StatsEniaMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.FIRST,
      firstScaffold: DashboardMainMenu(),
      secondScaffold: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              L10n.of(context).statsCentralTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 40,
            ),
            Image.asset('assets/logo.png', width: 100, height: 100),
          ],
        ),
      ),
    );
  }
}
