import 'package:fluffychat/utils/app_route.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'archive.dart';
import 'chat_list.dart';
import '../components/adaptive_page_layout.dart';
import '../components/dialogs/simple_dialogs.dart';
import '../components/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import 'enia_menu.dart';
import 'files_enia_menu.dart';
import 'formation_enia_menu.dart';
import 'settings.dart';
import 'stats_enia_menu.dart';
import 'stats_enia_menu_01.dart';

class StatsEniaMenu02View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.SECOND,
      firstScaffold: DashboardsList(),
      secondScaffold: StatsEniaMenu02(),
    );
  }
}

class DashboardsList extends StatefulWidget {
  @override
  _DashboardsListState createState() => _DashboardsListState();
}

class _DashboardsListState extends State<DashboardsList> {
  void _drawerTapAction(Widget view) {
    Navigator.of(context).pop();
    Navigator.of(context).pushAndRemoveUntil(
      AppRoute.defaultRoute(
        context,
        view,
      ),
      (r) => r.isFirst,
    );
  }

  void logoutAction(BuildContext context) async {
    if (await SimpleDialogs(context).askConfirmation() == false) {
      return;
    }
    var matrix = Matrix.of(context);
    await SimpleDialogs(context)
        .tryRequestWithLoadingDialog(matrix.client.logout());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: _scrolledToTop ? 0 : null,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => _drawerTapAction(
            ChatListView(),
          ),
        ),
        titleSpacing: 0,
        title: Text('Estadisticas Enia@virtual'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          ListTile(
            trailing: Icon(Icons.link),
            leading: Icon(Icons.bar_chart_outlined),
            //TODO: Esta info viene del YAML
            title: Text('SSyR: Salud Sexual y Reproductivo	'),
            subtitle:
                Text('Tablero de la direccion de Salud Sexual y Reproductiva	'),
            onTap: () => _drawerTapAction(
              StatsEniaMenu01View(),
            ),
          ),
          ListTile(
            trailing: Icon(Icons.link),
            leading: Icon(Icons.bar_chart_outlined),
            //TODO: Esta info viene del YAML
            title: Text('SSyR: Salud Sexual y Reproductivo 2	'),
            subtitle:
                Text('Tablero de la direccion de Salud Sexual y Reproductiva	'),
            onTap: () => _drawerTapAction(
              StatsEniaMenu02View(),
            ),
          ),
        ],
      ),
    );
  }
}

class StatsEniaMenu02 extends StatefulWidget {
  @override
  _StatsEniaMenu02State createState() => _StatsEniaMenu02State();
}

class _StatsEniaMenu02State extends State<StatsEniaMenu02> {
  Future<dynamic> profileFuture;
  dynamic profile;
  Future<bool> crossSigningCachedFuture;
  bool crossSigningCached;
  Future<bool> megolmBackupCachedFuture;
  bool megolmBackupCached;

  bool isShowingMainData = true;

  DateTime selectedDateNoRange;
  DateTimeRange selectedDate =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  final DateTime initialDate = DateTime.now();

  static const double barWidth = 22;

  Future<void> requestSSSSCache(BuildContext context) async {
    final handle = Matrix.of(context).client.encryption.ssss.open();
    final str = await SimpleDialogs(context).enterText(
      titleText: L10n.of(context).askSSSSCache,
      hintText: L10n.of(context).passphraseOrKey,
      password: true,
    );
    if (str != null) {
      SimpleDialogs(context).showLoadingDialog(context);
      // make sure the loading spinner shows before we test the keys
      await Future.delayed(Duration(milliseconds: 100));
      var valid = false;
      try {
        handle.unlock(recoveryKey: str);
        valid = true;
      } catch (_) {
        try {
          handle.unlock(passphrase: str);
          valid = true;
        } catch (_) {
          valid = false;
        }
      }
      await Navigator.of(context)?.pop();
      if (valid) {
        await handle.maybeCacheAll();
        await SimpleDialogs(context).inform(
          contentText: L10n.of(context).cachedKeys,
        );
        setState(() {
          crossSigningCachedFuture = null;
          crossSigningCached = null;
          megolmBackupCachedFuture = null;
          megolmBackupCached = null;
        });
      } else {
        await SimpleDialogs(context).inform(
          contentText: L10n.of(context).incorrectPassphraseOrKey,
        );
      }
    }
  }

  _selectDate(BuildContext context) async {
    var picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      helpText: 'Elija un rango de fechas',
      fieldStartHintText: 'Start Booking date',
      fieldEndHintText: 'End Booking date',
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 10)),
      ),
      //initialEntryMode:  DatePickerEntryMode.input,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(), // This will change to light theme.
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final client = Matrix.of(context).client;
    profileFuture ??= client.ownProfile.then((p) {
      if (mounted) setState(() => profile = p);
      return p;
    });
    crossSigningCachedFuture ??=
        client.encryption.crossSigning.isCached().then((c) {
      if (mounted) setState(() => crossSigningCached = c);
      return c;
    });
    megolmBackupCachedFuture ??=
        client.encryption.keyManager.isCached().then((c) {
      if (mounted) setState(() => megolmBackupCached = c);
      return c;
    });
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: true,
            pinned: true,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SSyR: Salud Sexual y Reproductivo 2',
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                  ),
                  DropdownButton<String>(
                    items: <String>[
                      'Salta',
                      'Misiones',
                      'Formosa',
                      'Jujuy',
                      'Chaco',
                      'Buenos Aires'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text('Provincia'),
                    onChanged: (_) {},
                  ),
                ],
              ),
              /*  background:  
              ContentBanner(
                profile?.avatarUrl,
                
                height: 300,
                //defaultIcon: Icons.account_circle,
                loading: profile == null,
                //onEdit: () => setAvatarAction(context),
              ), */
            ),
          ),
        ],
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                  'Tablero de la direccion de Salud Sexual y Reproductiva	'),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${selectedDate.start.toLocal()}".split(' ')[0],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 20),
                Text(
                  "${selectedDate.end.toLocal()}".split(' ')[0],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 20),
                RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    'Filtrar por fecha',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.greenAccent,
                ),
                /* FlatButton.icon(
                        icon: Icon(Icons.filter),
                        label: Text('Filtrar por fecha'),
                        onPressed: () {
                          _selectDate(context);
                          showDateRangePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025),
                          );
                        },
                      ), */
                SizedBox(width: 20),
                DropdownButton<String>(
                  items: <String>[
                    'Salta',
                    'Misiones',
                    'Formosa',
                    'Jujuy',
                    'Chaco',
                    'Buenos Aires'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text('Provincia'),
                  onChanged: (_) {},
                ),
                SizedBox(width: 40),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    'Year: ${selectedDateNoRange?.year}\nMonth: ${selectedDateNoRange?.month}'),
                SizedBox(width: 40),
                RaisedButton(
                  onPressed: () => showMonthPicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 1, 5),
                          lastDate: DateTime(DateTime.now().year + 1, 9),
                          initialDate: initialDate)
                      .then((date) => setState(() {
                            selectedDateNoRange = date;
                          })),
                  child: Text(
                    'Filtrar por fecha (Solo selecciona un mes)',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.blueAccent,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Card(
                    color: Color(0XFFF9F9F9),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text('Total de LARCS'),
                        subtitle: Text('Total de LARCS.'),
                        trailing: Icon(Icons.accessibility_new,
                            size: 50, color: Colors.green),
                        leading: Text(
                          '8902',
                          overflow: TextOverflow.visible,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Card(
              color: Color(0XFFF9F9F9),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      title:
                          Text('Dispensa de LARCs - Población objetivo plan'),
                      subtitle: Text(
                          'El modelo de estimación de metas de impacto o MEMI establece como población objetivo un 75% de mujeres sexualmente activas de 10 a 19 años en los 36 departamentos. '
                          'De este total, un 75% se estima cubrir con LARCs (70% con implantes, 5% con DIU); un total de 176.335 adolescentes a cubrir con LARCs en el período 2018-2019'),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    BarChartEnia(barWidth: barWidth),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Color(0XFFF9F9F9),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                                'Evolución mensual de la dispensa de LARCs'),
                            subtitle: Text(
                                'Durante 2019, el comportamiento de la dispensa reportada se estabiliza en 2.700 LARCs promedio mensual'),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          LineChart(
                            isShowingMainData ? sampleData1() : sampleData2(),
                            swapAnimationDuration:
                                const Duration(milliseconds: 250),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 100),
                            child: RaisedButton.icon(
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.black
                                    .withOpacity(isShowingMainData ? 1.0 : 0.5),
                              ),
                              label: Text(isShowingMainData
                                  ? 'Total LARCS'
                                  : 'Dispositivos de un tipo'),
                              onPressed: () {
                                setState(() {
                                  isShowingMainData = !isShowingMainData;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Color(0XFFF9F9F9),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ListTile(
                            title:
                                Text('Larcs estimados y dispensados por año'),
                            subtitle: Text(
                                'Considerando la población estimada a cubrir con LARCs para el 2020, a abril  2020 se alcanza un 10% de lo esperado. El desempeño para 2018 y 2019 estuvo en torno al 33% y 39% respectivamente. '),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          PieChartSample(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
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
        ),
      ),
      minX: 0,
      maxX: 4,
      maxY: 10000,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 4816),
        FlSpot(2, 7820),
        FlSpot(3, 1258),
      ],
      isCurved: true,
      colors: [
        Colors.green,
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    return [
      lineChartBarData1,
    ];
  }

  LineChartData sampleData2() {
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
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    final lineChartBarData1 = LineChartBarData(
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
    );

    return [
      lineChartBarData1,
    ];
  }
}

class BarChartEnia extends StatelessWidget {
  const BarChartEnia({
    Key key,
    @required this.barWidth,
  }) : super(key: key);

  final double barWidth;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        // XXXXXX VAR GRAFICO XXXXXX
        // El numero maximo del grafico eje Y
        maxY: 10000,
        // XXXXXX VAR GRAFICO XXXXXX
        // El numero minimo del grafico eje Y
        minY: 0,
        // distancia entre barras
        groupsSpace: 20,
        barTouchData: BarTouchData(
          enabled: true,
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: SideTitles(
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
          ),
          bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(color: Colors.red, fontSize: 10),
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
          ),
          leftTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(color: Colors.red, fontSize: 10),
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
            reservedSize: 30,
          ),
          rightTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(color: Colors.blue, fontSize: 10),
            rotateAngle: 0,
            getTitles: (double value) {
              if (value == 0) {
                return '0';
              }
              return '${value.toInt()}00 LARCs';
            },
            interval: 3000,
            margin: 8,
            reservedSize: 30,
          ),
        ),
        gridData: FlGridData(
          show: true,
          checkToShowHorizontalLine: (value) => value % 1000 == 0,
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
        borderData: FlBorderData(
          show: true,
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                y: 4816,
                width: barWidth,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                rodStackItems: [
                  BarChartRodStackItem(0, 1200, const Color(0xffff4d94)),
                  BarChartRodStackItem(1200, 4816, const Color(0xff19bfff)),
                ],
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                y: 7820,
                width: barWidth,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                rodStackItems: [
                  BarChartRodStackItem(0, 3200, const Color(0xffff4d94)),
                  BarChartRodStackItem(3200, 7820, const Color(0xff19bfff)),
                ],
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                y: 1258,
                width: barWidth,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                rodStackItems: [
                  BarChartRodStackItem(0, 600, const Color(0xffff4d94)),
                  BarChartRodStackItem(600, 1258, const Color(0xff19bfff)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}

class PieChartSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartState();
}

class PieChartState extends State {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(
          height: 18,
        ),
        Expanded(
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  setState(() {
                    if (pieTouchResponse.touchInput is FlLongPressEnd ||
                        pieTouchResponse.touchInput is FlPanEnd) {
                      touchedIndex = -1;
                    } else {
                      touchedIndex = pieTouchResponse.touchedSectionIndex;
                    }
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 100,
                centerSpaceRadius: 16,
                sections: showingSections()),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Indicator(
              color: Color(0xff0293ee),
              text: '2018',
              isSquare: true,
            ),
            SizedBox(
              height: 4,
            ),
            Indicator(
              color: Color(0xfff8b250),
              text: '2019',
              isSquare: true,
            ),
            SizedBox(
              height: 4,
            ),
            Indicator(
              color: Color(0xff845bef),
              text: '2020',
              isSquare: true,
            ),
            SizedBox(
              height: 18,
            ),
          ],
        ),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 100 : 80;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '2320',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );

        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 50,
            title: '4550',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 10,
            title: '855',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );

        default:
          return null;
      }
    });
  }
}

Future<DateTime> showMonthPicker({
  @required BuildContext context,
  @required DateTime initialDate,
  DateTime firstDate,
  DateTime lastDate,
}) async {
  assert(context != null);
  assert(initialDate != null);
  return await showDialog<DateTime>(
      context: context,
      builder: (context) => _MonthPickerDialog(
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
          ));
}

class _MonthPickerDialog extends StatefulWidget {
  final DateTime initialDate, firstDate, lastDate;

  const _MonthPickerDialog({
    Key key,
    @required this.initialDate,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  @override
  _MonthPickerDialogState createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<_MonthPickerDialog> {
  PageController pageController;
  DateTime selectedDate;
  int displayedPage;
  bool isYearSelection = false;

  DateTime _firstDate, _lastDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime(widget.initialDate.year, widget.initialDate.month);
    if (widget.firstDate != null)
      _firstDate = DateTime(widget.firstDate.year, widget.firstDate.month);
    if (widget.lastDate != null)
      _lastDate = DateTime(widget.lastDate.year, widget.lastDate.month);
    displayedPage = selectedDate.year;
    pageController = PageController(initialPage: displayedPage);
  }

  String _locale(BuildContext context) {
    var locale = Localizations.localeOf(context);
    if (locale == null) {
      return Intl.systemLocale;
    }
    return '${locale.languageCode}_${locale.countryCode}';
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var localizations = MaterialLocalizations.of(context);
    var locale = _locale(context);
    var header = buildHeader(theme, locale);
    var pager = buildPager(theme, locale);
    var content = Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [pager, buildButtonBar(context, localizations)],
      ),
      color: theme.dialogBackgroundColor,
    );
    return Theme(
        data: Theme.of(context)
            .copyWith(dialogBackgroundColor: Colors.transparent),
        child: Dialog(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Builder(builder: (context) {
            if (MediaQuery.of(context).orientation == Orientation.portrait) {
              return IntrinsicWidth(
                child: Column(children: [header, content]),
              );
            }
            return IntrinsicHeight(
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [header, content]),
            );
          })
        ])));
  }

  Widget buildButtonBar(
    BuildContext context,
    MaterialLocalizations localizations,
  ) {
    return ButtonTheme(
        child: ButtonBar(children: <Widget>[
      FlatButton(
        onPressed: () => Navigator.pop(context, null),
        child: Text(localizations.cancelButtonLabel),
      ),
      FlatButton(
        onPressed: () => Navigator.pop(context, selectedDate),
        child: Text(localizations.okButtonLabel),
      )
    ]));
  }

  Widget buildHeader(ThemeData theme, String locale) {
    return Material(
        color: theme.primaryColor,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${DateFormat.yMMM(locale).format(selectedDate)}',
                    style: theme.primaryTextTheme.subhead,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if (!isYearSelection)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isYearSelection = true;
                              });
                              // pageController.jumpToPage(displayedPage ~/ 12);
                            },
                            child: Text(
                              '${DateFormat.y(locale).format(DateTime(displayedPage))}',
                              style: theme.primaryTextTheme.headline,
                            ),
                          ),
                        if (isYearSelection)
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${DateFormat.y(locale).format(DateTime(displayedPage * 12))}',
                                  style: theme.primaryTextTheme.headline,
                                ),
                                Text(
                                  '-',
                                  style: theme.primaryTextTheme.headline,
                                ),
                                Text(
                                  '${DateFormat.y(locale).format(DateTime(displayedPage * 12 + 11))}',
                                  style: theme.primaryTextTheme.headline,
                                )
                              ]),
                        Row(children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_up,
                              color: theme.primaryIconTheme.color,
                            ),
                            onPressed: () => pageController.animateToPage(
                                displayedPage - 1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: theme.primaryIconTheme.color,
                            ),
                            onPressed: () => pageController.animateToPage(
                                displayedPage + 1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut),
                          )
                        ])
                      ])
                ])));
  }

  Widget buildPager(ThemeData theme, String locale) {
    return SizedBox(
        height: 220.0,
        width: 300.0,
        child: Theme(
            data: theme.copyWith(
              buttonTheme: ButtonThemeData(
                padding: EdgeInsets.all(2.0),
                shape: CircleBorder(),
                minWidth: 4.0,
              ),
            ),
            child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: (index) {
                  setState(() {
                    displayedPage = index;
                  });
                },
                itemBuilder: (context, page) {
                  return GridView.count(
                    padding: EdgeInsets.all(8.0),
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    children: isYearSelection
                        ? List<int>.generate(12, (i) => page * 12 + i)
                            .map(
                              (year) => Padding(
                                padding: EdgeInsets.all(4.0),
                                child: _getYearButton(year, theme, locale),
                              ),
                            )
                            .toList()
                        : List<int>.generate(12, (i) => i + 1)
                            .map((month) => DateTime(page, month))
                            .map(
                              (date) => Padding(
                                padding: EdgeInsets.all(4.0),
                                child: _getMonthButton(date, theme, locale),
                              ),
                            )
                            .toList(),
                  );
                })));
  }

  Widget _getMonthButton(
      final DateTime date, final ThemeData theme, final String locale) {
    VoidCallback callback;
    if (_firstDate == null && _lastDate == null)
      callback =
          () => setState(() => selectedDate = DateTime(date.year, date.month));
    else if (_firstDate != null &&
        _lastDate != null &&
        _firstDate.compareTo(date) <= 0 &&
        _lastDate.compareTo(date) >= 0)
      callback =
          () => setState(() => selectedDate = DateTime(date.year, date.month));
    else if (_firstDate != null &&
        _lastDate == null &&
        _firstDate.compareTo(date) <= 0)
      callback =
          () => setState(() => selectedDate = DateTime(date.year, date.month));
    else if (_firstDate == null &&
        _lastDate != null &&
        _lastDate.compareTo(date) >= 0)
      callback =
          () => setState(() => selectedDate = DateTime(date.year, date.month));
    else
      callback = null;
    return FlatButton(
      onPressed: callback,
      color: date.month == selectedDate.month && date.year == selectedDate.year
          ? theme.accentColor
          : null,
      textColor:
          date.month == selectedDate.month && date.year == selectedDate.year
              ? theme.accentTextTheme.button.color
              : date.month == DateTime.now().month &&
                      date.year == DateTime.now().year
                  ? theme.accentColor
                  : null,
      child: Text(
        DateFormat.MMM(locale).format(date),
      ),
    );
  }

  Widget _getYearButton(int year, ThemeData theme, String locale) {
    return FlatButton(
      onPressed: () {
        pageController.jumpToPage(year);
        setState(() {
          isYearSelection = false;
        });
      },
      color: year == selectedDate.year ? theme.accentColor : null,
      textColor: year == selectedDate.year
          ? theme.accentTextTheme.button.color
          : year == DateTime.now().year
              ? theme.accentColor
              : null,
      child: Text(
        DateFormat.y(locale).format(DateTime(year)),
      ),
    );
  }
}
