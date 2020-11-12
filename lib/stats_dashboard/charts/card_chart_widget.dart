import 'package:fluffychat/stats_dashboard/models/card_chart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


class CardEniaStats extends StatefulWidget {
  CardEniaStats({@required this.apiUrl});

  final String apiUrl;

  @override
  _CardEniaStatsState createState() => _CardEniaStatsState();
}

class _CardEniaStatsState extends State<CardEniaStats> {
  CardChartInfo cardChartInfo = CardChartInfo();

  String cardData;

  Future<CardChartInfo> loadChartFromApi() async {
    var cardChartInfoJson = await rootBundle.loadString(widget.apiUrl);

    cardChartInfo = await cardChartInfoFromJson(cardChartInfoJson);

    cardData = cardChartInfo.cardData;

    return cardChartInfo;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadChartFromApi(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Text(L10n.of(context).noInternet),
            );
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
              return Center(child: Text(L10n.of(context).somethingWrong),);
            } else {
              if (snapshot.data != null) {
                return Text(
                  cardData,
                  overflow: TextOverflow.visible,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.green),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
