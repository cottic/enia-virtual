import 'package:flutter/material.dart';

import 'filter_stats_widget.dart';

class HeaderUniqueDashboard extends StatelessWidget {
  const HeaderUniqueDashboard({@required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      elevation: 0,
      floating: true,
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: Theme.of(context).primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                title,
              ),
            ),
            Expanded(
              flex: 2,
              child: FiltersStats(),
            ),
          ],
        ),
      ),
    );
  }
}
