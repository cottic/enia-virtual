import 'package:fluffychat/stats_dashboard/charts/card_chart_widget.dart';
import 'package:flutter/material.dart';

import 'enia_icons_icons.dart';

class CardChartHolder extends StatelessWidget {
  const CardChartHolder(
      {this.title, this.description, this.icon, this.chartUrl, this.color});

  final String title;
  final String description;
  final String icon;
  final String chartUrl;
  final bool color;

  @override
  Widget build(BuildContext context) {
    bool screenSize = false;
    // print(MediaQuery.of(context).size.width);
    if (MediaQuery.of(context).size.width <= 1160) {
      screenSize = true;
    } else {
      screenSize = false;
    }
    return Expanded(
      // width: MediaQuery.of(context).size.width * 0.17,
      // height: 100,

      child: Card(
        elevation: 3.0,
        margin: EdgeInsets.all(10.0),
        color: Color(0XFFFAFAFA),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                  icon == 'accessibility_new'
                      ? EniaIcons.adolescente
                      : icon == 'ninios'
                          ? EniaIcons.ninios
                          : icon == 'diu'
                              ? EniaIcons.diu
                              : icon == 'implante'
                                  ? EniaIcons.implante
                                  : EniaIcons.adolescente,
                  size: screenSize ? 40 : 60,
                  color: color
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).accentColor),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: CardEniaStats(
                      color: color
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).accentColor,
                      apiUrl: chartUrl,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      title ?? '',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(color: Color(0XFFA6A6A6), fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        /* ListTile(
          contentPadding: EdgeInsets.all(10.0),
          visualDensity: VisualDensity(horizontal: 0.5, vertical: 1),
          title: dataWidget,
          subtitle: Text(
            title ?? '',
            overflow: TextOverflow.ellipsis,
          ),
          leading: Icon(icon,
              size: screenSize ? 20 : 60,
              color: Theme.of(context).primaryColor),
        ), */
      ),
    );
  }
}
