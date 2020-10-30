import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  bool isShowingMainData = true;

  // Las lineas del fondo del grafico
  //  checkToShowHorizontalLine: (value) => value % backLinesDividedByValue == 0,
  static const double backLinesDividedByValue = 100000;

  // TITULOS BOTON QUE SWITCHEA LA INFO
  static const String buttonTitle01 = 'Total LARCS';
  static const String buttonTitle02 = 'Dispositivos de un tipo';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Indica la info que muestra, si se presiona el boton, switchea
        LineChart(
          isShowingMainData ? dataLarcsFull() : dataLarcsDesagregada(),
          swapAnimationDuration: const Duration(milliseconds: 250),
        ),
        // Boton que switchea la info
        Container(
          margin: EdgeInsets.symmetric(horizontal: 100),
          child: RaisedButton.icon(
            icon: Icon(
              Icons.refresh,
              color: Colors.black.withOpacity(isShowingMainData ? 1.0 : 0.5),
            ),
            label: Text(isShowingMainData ? buttonTitle01 : buttonTitle02),
            onPressed: () {
              setState(() {
                isShowingMainData = !isShowingMainData;
              });
            },
          ),
        ),
      ],
    );
  }

  LineChartData dataLarcsFull() {
    // La cantidad de items debe ser igual a max items
    var listTitlesX = ['', '2018', '2019', '2020', '2021', '2022', '', ''];

    var maxItems = 7.0;

    return LineChartData(
      // DONDE COMIENZA EJE X // No puede ser menor a 0
      minX: 0,
      // DONDE TERMINA EJE X
      maxX: maxItems,
      // DONDE EMPIEZA EJE Y
      minY: 0,
      // DONDE TERMINA EJE Y
      maxY: 1000000,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, 481600),
            FlSpot(2, 782000),
            FlSpot(3, 125800),
            FlSpot(4, 481600),
            FlSpot(5, 782000),
            FlSpot(6, 125800),
          ],
          isCurved: true,
          colors: [
            Colors.green,
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
        ),
        LineChartBarData(
          spots: [
     
            FlSpot(2, 582000),
            FlSpot(3, 425800),
            FlSpot(4, 681600),
            FlSpot(5, 782000),
           
          ],
          isCurved: true,
          colors: [
            Colors.blue,
          ],
          barWidth: 8,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
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

  LineChartData dataLarcsDesagregada() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '2018';
              case 2:
                return '2019';
              case 3:
                return '2020';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
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
          interval: 3000,
          margin: 8,
          reservedSize: 50,
        ),
      ),
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
          )),
      minX: 0,
      maxX: 4,
      maxY: 10000,
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, 2320),
            FlSpot(2, 4550),
            FlSpot(3, 855),
          ],
          isCurved: true,
          colors: [
            Colors.amber,
          ],
          barWidth: 8,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
        )
      ],
    );
  }
}
