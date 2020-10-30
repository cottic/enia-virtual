import 'package:fl_chart/fl_chart.dart';
import 'package:fluffychat/stats_dashboard/pie_indicator_widget.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  // ESTILOS
  static const double barWidth = 22;

  //COSAS QUE VIENEN DE API
  // El numero maximo del grafico eje Y
  static const double maxY = 1000000;
  // El numero minimo del grafico eje Y / Puede ser negativo
  static const double minY = 0;
  // Lista ccon los titulos eje X
  static const List<String> listTitlesX = ['2018', '2019', '2020', '2021'];

  static const String titlesYright = 'LARCs';
  static const double intervalY = 300000;
  // Las lineas del fondo del grafico
  //  checkToShowHorizontalLine: (value) => value % backLinesDividedByValue == 0,
  static const double backLinesDividedByValue = 100000;

  static List<BarChartGroupData> barData = [
    BarChartGroupData(
      // El id puede venir o lo puede generar solo.
      x: 0,
      barRods: [
        BarChartRodData(
          // El numero del tope
          y: 481600,
          width: barWidth,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          // Lista de sub colores si tiene
          rodStackItems: [
            // Aca seria Objeto BarRod.listaStackItems
            // BarChartRodStackItem(0, 110000, const Color(0xffff4d94)),
            // BarChartRodStackItem(110000, 481600, const Color(0xff19bfff)),
            // BarChartRodStackItem(481600, 581600, Colors.black),
          ],
        ),
        BarChartRodData(
          y: 588000,
          width: barWidth,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          rodStackItems: [
            BarChartRodStackItem(0, 110000, const Color(0xffff4d94)),
            BarChartRodStackItem(110000, 481600, const Color(0xff19bfff)),
            BarChartRodStackItem(481600, 581600, Colors.black),
          ],
        ),
        BarChartRodData(
          y: 320000,
          width: barWidth,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          rodStackItems: [
            BarChartRodStackItem(0, 180000, const Color(0xffff4d94)),
            BarChartRodStackItem(180000, 481600, const Color(0xff19bfff)),
          ],
        ),
      ],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          y: 782000,
          width: barWidth,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          rodStackItems: [
            BarChartRodStackItem(0, 320000, const Color(0xffff4d94)),
            BarChartRodStackItem(320000, 782000, const Color(0xff19bfff)),
          ],
        ),
      ],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          y: 125800,
          width: barWidth,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          rodStackItems: [
            BarChartRodStackItem(0, 60000, const Color(0xffff4d94)),
            BarChartRodStackItem(60000, 125008, const Color(0xff19bfff)),
          ],
        ),
      ],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          y: 125800,
          width: barWidth,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          rodStackItems: [
            BarChartRodStackItem(0, 60000, const Color(0xffff4d94)),
            BarChartRodStackItem(60000, 125800, const Color(0xff19bfff)),
          ],
        ),
      ],
    ),
  ];

  List<Indicator> indicatorList = [
    Indicator(
      color: Color(0xff0293ee),
      text: '2018',
      isSquare: false,
    ),
    Indicator(
      color: Color(0xfff8b250),
      text: '2019',
      isSquare: true,
    ),
    Indicator(
      color: Color(0xff845bef),
      text: '2020',
      isSquare: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: indicatorList,
        ),
        SizedBox(
          height: 10,
        ),
        BarChart(
          BarChartData(
            alignment: BarChartAlignment.center,
            // XXXXXX VAR GRAFICO XXXXXX
            // El numero maximo del grafico eje Y
            maxY: maxY,
            // XXXXXX VAR GRAFICO XXXXXX
            // El numero minimo del grafico eje Y
            minY: minY,
            // distancia entre barras
            groupsSpace: 20,
            barTouchData: BarTouchData(
              enabled: true,
            ),
            titlesData: FlTitlesData(
              show: true,
              // TITULO SUPERIOR
              /* topTitles: SideTitles(
                showTitles: true,
                textStyle: TextStyle(color: Colors.orange, fontSize: 10),
                margin: 10,
                rotateAngle: 0,
                getTitles: (double value) {
                  switch (value.toInt()) {
                    case 0:
                      return '2018';
                    case 1:
                      return '2019';
                    case 2:
                      return '2020';
                    default:
                      return '';
                  }
                },
              ), */
              // TITULO INFERIOR
              bottomTitles: SideTitles(
                showTitles: true,
                textStyle: TextStyle(color: Colors.red, fontSize: 10),
                margin: 10,
                rotateAngle: 0,
                getTitles: (double value) {
                  for (var i = 0; i < listTitlesX.length; i++) {
                    return listTitlesX[value.toInt()];
                  }
                  return '';
                },
              ),
              // TITULOS IZQUIERDA
              leftTitles: SideTitles(
                showTitles: false,
                /*  textStyle: TextStyle(color: Colors.red, fontSize: 10),
                rotateAngle: 45,
                getTitles: (double value) {
                  //print('value');
                  //print(value);

                  if (value == 0) {
                    return '0';
                  }
                  return '${value.toInt()}00 LARCs';
                },
                interval: 1000,
                margin: 8,
                reservedSize: 30, */
              ),
              // TITULOS DERECHA
              rightTitles: SideTitles(
                showTitles: true,
                textStyle: TextStyle(color: Colors.blue, fontSize: 10),
                rotateAngle: 0,
                getTitles: (double value) {
                  if (value == 0) {
                    return '0';
                  }
                  return '${value.toInt()} $titlesYright';
                },
                interval: intervalY,
                margin: 8,
                reservedSize: 30,
              ),
            ),
            // DATA SOBRE LA GRID (linead de atras en el grafico)
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
            // GRAFICO CON O SIN BORDE
            borderData: FlBorderData(
              show: true,
            ),
            barGroups: barData,
          ),
        ),
      ],
    );
  }
}
