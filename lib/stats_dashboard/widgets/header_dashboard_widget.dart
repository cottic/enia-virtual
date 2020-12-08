import 'package:flutter/material.dart';

import '../constants_dashboard.dart';
import 'filter_stats_widget.dart';

class HeaderUniqueDashboard extends StatelessWidget {
  const HeaderUniqueDashboard(
      {@required this.title,
      this.onPressDateFrom,
      this.dateFromString,
      this.onPressDateTo,
      this.dateToString,
      this.filterDropDown});

  final Function onPressDateFrom;
  final String dateFromString;

  final Function onPressDateTo;
  final String dateToString;

  final DropdownButton filterDropDown;

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
        titlePadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  title,
                  style: headerMain,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            /* SizedBox(
              height: 10,
            ), */
            Expanded(
              flex: 2,
              child: FiltersStats(
                onPressDateFrom: onPressDateFrom,
                dateFromString: dateFromString,
                dateToString: dateToString,
                onPressDateTo: onPressDateTo,
                filterDropDown: filterDropDown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*            Expanded(
              flex: 1,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 2,
              child: FiltersStats(),
            ), */
