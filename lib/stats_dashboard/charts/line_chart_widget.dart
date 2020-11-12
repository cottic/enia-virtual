import 'package:fl_chart/fl_chart.dart';
import 'package:fluffychat/stats_dashboard/widgets/indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

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
    var lineChartInfoJson = await rootBundle.loadString(widget.apiUrl);

    lineChartInfo = lineChartInfoFromJson(lineChartInfoJson);

    indicators = lineChartInfo.indicatorsList;

    if (lineChartInfo.lineBarsData != null) {
      for (var lineBarsData in lineChartInfo.lineBarsData) {
        final isCurved = lineBarsData.isCurved;
        final color = lineBarsData.color;
        final List<FlSpot> spotsList = [];

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
          barWidth: 8,
          isStrokeCapRound: true,
          // Mostrar puntos en la linea
          dotData: FlDotData(
            show: false,
          ),
          // Mostrar relleno debajo de la linea
          belowBarData: BarAreaData(
            show: false,
          ),
        );

        lines.add(lineChart);
      }
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
              return Center(child: Text(L10n.of(context).somethingWrong),);
            } else {
              if (snapshot.data != null) {
                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: indicators,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LineChart(
                      dataLarcsFull(),
                    ),
                  ],
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

  LineChartData dataLarcsFull() {
    // La cantidad de items debe ser igual a max items
    // Define la lista que contiene los titulos inferiores del grafico
    var listTitlesX = lineChartInfo.listTitlesX;

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
      // TODO: definir estilos
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.red.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      // DEFINE EL GRID EN EL FONDO DEL GRAFICO
      gridData: FlGridData(
        show: true,
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
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (double value) {
            for (var i = 0; i < listTitlesX.length; i++) {
              if (listTitlesX[value.toInt()] != null) {
                return listTitlesX[value.toInt()];
              }
            }
            return '';
          },
        ),
        // TITULOS IZQUIERDA
        leftTitles: SideTitles(showTitles: false),
        // TITULOS DERECHA
        rightTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (double value) {
            if (value == 0) {
              return '0';
            }
            return '${value.toInt()} LARCs';
          },
          interval: 300000,
          margin: 8,
          reservedSize: 50,
        ),
      ),
      // ESTILOS DE LOS BORDES
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
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
