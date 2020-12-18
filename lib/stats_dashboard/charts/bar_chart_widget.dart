import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import '../models/bar_chart_model.dart';
import '../constants_dashboard.dart';
import 'package:fluffychat/stats_dashboard/services/dashboard_services.dart';

class BarChartWidget extends StatefulWidget {
  BarChartWidget({@required this.apiUrl});

  final String apiUrl;

  @override
  _BarChartWidgetState createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  BarChartInfo barChartInfo;

  List indicators;

  List barCharts;

  List<BarChartGroupData> barGroupsList = [];

  Future<BarChartInfo> loadChartFromApi() async {
    var barChartInfoJson =
        await DashboardService().loadChartFromApi(widget.apiUrl);

    barChartInfo = barChartInfoFromJson(barChartInfoJson);

    // ignore: omit_local_variable_types
    List<BarChartGroupData> barGroupsListInter = [];
    // if you dont declare, it fails
    if (barChartInfo.barChartList != null && barChartInfo.maxNumberY > 1) {
      for (var barCharItem in barChartInfo.barChartList) {
        // ignore: omit_local_variable_types
        List<BarChartRodData> barGroupBars = [];
        // if you dont declare, it fails
        for (var barRodItem in barCharItem.barRods) {
          // ignore: omit_local_variable_types
          List<BarChartRodStackItem> barSegmentsList = [];
          // if you dont declare, it fails

          for (var barSegments in barRodItem.barChartRoddData) {
            final barSegment = BarChartRodStackItem(
              barSegments.start,
              barSegments.end,
              HexColor(barSegments.color),
            );

            barSegmentsList.add(barSegment);
          }

          final barItem = BarChartRodData(
            y: barRodItem.totalY,
            width: MediaQuery.of(context).size.width * 0.007,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: barSegmentsList,
          );

          barGroupBars.add(barItem);
        }

        final barGroupItem = BarChartGroupData(
          x: barCharItem.x,
          barRods: barGroupBars,
        );

        barGroupsListInter.add(barGroupItem);
      }
      barGroupsList = barGroupsListInter;
    } else {
      return barChartInfo = null;
    }

    indicators = barChartInfo.indicators;
    barCharts = barChartInfo.barChartList;

    return barChartInfo;
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
              return Center(
                child: Text(L10n.of(context).somethingWrong),
              );
            } else {
              if (snapshot.data != null) {
                return Stack(
                  children: [
                    Container(
                      height: 240.0,
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: BarChart(
                        barChartData(),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: indicators,
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text(L10n.of(context).noInfoAvailable),
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

  BarChartData barChartData() {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      // XXXXXX VAR GRAFICO XXXXXX
      // El numero maximo del grafico eje Y
      maxY: barChartInfo.maxNumberY,
      // XXXXXX VAR GRAFICO XXXXXX
      // El numero minimo del grafico eje Y
      minY: barChartInfo.minNumberY,
      // distancia entre barras
      groupsSpace: 10,
      barTouchData: BarTouchData(
        enabled: true,
        //No le puedo asignar borde al tooltip
        // touchTooltipData: BarTouchTooltipData(),
      ),
      titlesData: FlTitlesData(
        show: true,

        // TITULO SUPERIOR
        topTitles: SideTitles(
          showTitles: false,
        ),
        // TITULOS IZQUIERDA
        rightTitles: SideTitles(
          showTitles: false,
        ),
        // TITULO INFERIOR
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => bottomTitlesChart,
          margin: 30,
          // reservedSize: 100,
          rotateAngle: 20,
          getTitles: (double value) {
            for (var i = 0; i < barChartInfo.listTitlesX.length; i++) {
              return barChartInfo.listTitlesX[value.toInt()];
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => leftTitlesChart,
          rotateAngle: 0,
          getTitles: (double value) {
            if (value == 0) {
              return '0';
            }
            return '${value.toInt()} ${barChartInfo.titlesYright.toString()}';
          },
          interval: barChartInfo.intervalY,
          margin: 8,
          reservedSize: 30,
        ),
      ),
      // DATA SOBRE LA GRID (linead de atras en el grafico)
      gridData: FlGridData(
        show: false,
        checkToShowHorizontalLine: (value) =>
            value % barChartInfo.backLinesDividedByMaxNumberY == 0,
        getDrawingHorizontalLine: (value) {
          if (value == 0) {
            return FlLine(color: const Color(0xff363753), strokeWidth: 3);
          }
          return FlLine(
            color: const Color(0xff2a2747),
            strokeWidth: 0.8,
          );
        },
      ),
      // GRAFICO CON O SIN BORDE
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: barGroupsList,
    );
  }
}
