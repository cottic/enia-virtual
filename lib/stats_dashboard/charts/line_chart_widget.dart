import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'package:fluffychat/stats_dashboard/widgets/indicator_widget.dart';
import 'package:fluffychat/stats_dashboard/services/dashboard_services.dart';
import '../constants_dashboard.dart';
import '../models/line_chart_model.dart';

class LineChartWidget extends StatefulWidget {
  LineChartWidget({@required this.apiUrl});

  final String apiUrl;

  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  // Las lineas del fondo del grafico
  //  checkToShowHorizontalLine: (value) => value % backLinesDividedByValue == 0,
  static const double backLinesDividedByValue = 100000;

  List<IndicatorWidget> indicators = [];

  LineChartInfo lineChartInfo;

  List<LineChartBarData> lines = [];

  Future<LineChartInfo> loadChartFromApi() async {
    var lineChartInfoJson =
        await DashboardService().loadChartFromApi(widget.apiUrl);

    lineChartInfo = lineChartInfoFromJson(lineChartInfoJson);

    indicators = lineChartInfo.indicatorsList;

    if (lineChartInfo.lineBarsData != null && lineChartInfo.maxX > 1) {
      for (var lineBarsData in lineChartInfo.lineBarsData) {
        final isCurved = lineBarsData.isCurved;
        final color = lineBarsData.color;
        // ignore: omit_local_variable_types
        final List<FlSpot> spotsList = [];
        // if you dont declare, it fails

        for (var i = 0; i < lineBarsData.spots.length; i++) {
          final spotsItems = lineBarsData.spots;
          final spotItem =
              FlSpot(spotsItems[i].spotPosition, spotsItems[i].spotNumber);

          spotsList.add(spotItem);
        }

        final lineChart = LineChartBarData(
          spots: spotsList,
          isCurved: isCurved,
          colors: [
            HexColor(color),
          ],
          barWidth: 3,

          isStrokeCapRound: true,
          // Mostrar puntos en la linea
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) =>
                FlDotCirclePainter(
              radius: 4,
              color: HexColor(color),
              strokeWidth: 1,
              strokeColor: Colors.white,
            ),
          ),
          // Mostrar relleno debajo de la linea
          belowBarData: BarAreaData(
            show: false,
          ),
        );

        lines.add(lineChart);
      }
    } else {
      return lineChartInfo = null;
    }
    return lineChartInfo;
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
                  children: <Widget>[
                    Container(
                      height: 240,
                      margin: EdgeInsets.only(top: 26.0, right: 20.0),
                      width: double.infinity,
                      child: LineChart(
                        dataLarcsFull(),
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

  LineChartData dataLarcsFull() {
    return LineChartData(
      // DONDE COMIENZA EJE X // No puede ser menor a 0
      minX: lineChartInfo.minX,
      // DONDE TERMINA EJE X
      maxX: lineChartInfo.maxX,
      // DONDE EMPIEZA EJE Y
      minY: lineChartInfo.minY,
      // DONDE TERMINA EJE Y
      maxY: lineChartInfo.maxY,
      // Estas son la lista de las lineas del grafico
      lineBarsData: lines,

      // Muestra el detalle al hacer clic sobre la linea
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
        fullHeightTouchLine: false,
        enabled: true,
      ),
      // DEFINE EL GRID EN EL FONDO DEL GRAFICO
      gridData: FlGridData(
        show: false,
        checkToShowHorizontalLine: (value) =>
            value % backLinesDividedByValue == 0,
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
      // INFORMACION DE LOS TITULOS
      titlesData: FlTitlesData(
        // TITULO INFERIOR
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTextStyles: (value) => bottomTitlesChart,
          margin: 10,
          rotateAngle: 45,
          getTitles: (double value) {
            for (var i = 0; i < lineChartInfo.listTitlesX.length; i++) {
              return lineChartInfo.listTitlesX[value.toInt()];
            }
            return '';
          },
        ),
        rightTitles: SideTitles(showTitles: false),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => leftTitlesChart,
          getTitles: (double value) {
            if (value == 0) {
              return '0';
            }
            return '${value.toInt()} LARCs';
          },
          interval: lineChartInfo.intervalY,
          margin: 8,
          reservedSize: 50,
        ),
      ),
      // ESTILOS DE LOS BORDES
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.transparent,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
