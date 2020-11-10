import 'package:fluffychat/stats_dashboard/models/card_chart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                child: Text('Please connect to inernet an try again'));
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
              print(snapshot.error.toString());
              //TODO: internazionalizar texto
              return Center(child: Text('Algo salio mal //'));
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
