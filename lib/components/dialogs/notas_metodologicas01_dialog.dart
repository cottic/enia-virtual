import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class FrequentMessageDialog extends StatefulWidget {
  final Function onFinished;

  FrequentMessageDialog({this.onFinished, Key key}) : super(key: key);

  @override
  _FrequentMessageDialogState createState() => _FrequentMessageDialogState();
}

class _FrequentMessageDialogState extends State<FrequentMessageDialog> {
  bool error = false;
  bool get searchMode => searchController.text?.isNotEmpty ?? false;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (error) {
      Timer(Duration(seconds: 1), () {
        Navigator.of(context).pop();
      });
    }
    return AlertDialog(
      contentPadding: EdgeInsets.all(8),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.7,
        child: FutureBuilder<List<FrequentMessagesInfo>>(
          future: getFrequent(),
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
                    return Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.only(bottom: 10, left: 5, top: 6),
                          child: Text(
                            'Notas Metodológicas',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Expanded(
                            child: ListView(children: <Widget>[
                          ListTile(
                            title: Text(
                              'Se presenta información de la cantidad de total de LARC1 dispensados e informados a monitoreo del Plan Enia según población objetivo, en departamentos priorizados, total y por tipo (Implante subdérmico y DIU). Conjuntamente se presenta la cantidad de servicios de salud que informaron esa dispensa.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Tarjetas',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                'La tarjeta “Total dispensados” muestra la cantidad de LARC (implantes subdérmicos y DIU) dispensados a población objetivo en la jurisdicción y el período seleccionados.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                'La tarjeta “Subdérmicos” muestra la cantidad de este tipo de LARC dispensados a población objetivo en la jurisdicción y el período seleccionados.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                'La tarjeta “DIU” muestra la cantidad de este tipo de LARC dispensados a población objetivo en la jurisdicción y el período seleccionados. Se consideran el total de DIU: DIU, DIU MULTILOAD y DIU_LNG –hormonal-. '),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                'La tarjeta “Servicios de salud involucrados” muestra la cantidad de servicios de salud que informaron dispensa de LARC en la jurisdicción y el período seleccionados. '),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            title: Text(
                              'Gráficos',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                '“Dispensado por jurisdicción”: presenta en valores absolutos la cantidad de LARC dispensados a población objetivo del Plan por jurisdicción en el período seleccionado.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                '“Dispensados por tipo de efector”: presenta en porcentaje la dispensa de LARC por tipo de efector (CAPS, Hospital, Otro –incluye servicios móviles, programas itinerantes, CIC, equipos territoriales y programas provinciales de SSR-) en la jurisdicción y  el período seleccionados.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                '“Evolución mensual de la dispensa”: presenta en valores absolutos la cantidad de LARC dispensados por mes a población objetivo del Plan en la jurisdicción y el período seleccionado.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            title: Text(
                              'Frecuencia de actualización',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                                'Los tableros presentan información mensual con actualización trimestral, diferida a dos meses de su recolección: período en que se realizan sistematizaciones, validaciones, ajustes de consistencia y el procesamiento. Este proceso puede implicar variaciones menores en los datos históricos debido a la incorporación de datos informados con posterioridad a la fecha de corte para el procesamiento.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            title: Text(
                              'Visualización',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                                'Los tableros permiten seleccionar períodos de tiempo de un mes o mayores y también seleccionar jurisdicciones: total Enia, provincia o departamento.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            title: Text(
                                'Nota 1. Los LARC (métodos anticonceptivos reversibles de larga duración en su sigla en inglés: Long-acting reversible contraception) incluyen implantes subdérmicos y DIU. '),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            title: Text(
                                'Fuente: Planilla dispensa de LARC, Monitoreo Enia. DNSSR, SAS, Ministerio de Salud de la Nación.'),
                            subtitle: Text(''),
                          ),
                        ])),
                        ButtonCancel(),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Icon(
                          Icons.error,
                          size: 50,
                        ),
                        SizedBox(height: 20.0),
                        Text(L10n.of(context).somethingWrong),
                        Expanded(
                          child: Container(),
                        ),
                        ButtonCancel(),
                      ],
                    );
                  }
                }
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class ButtonCancel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        L10n.of(context).cancel.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText2.color.withAlpha(150),
        ),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

List<FrequentMessagesInfo> frequentMessagesInfoFromJson(String str) =>
    List<FrequentMessagesInfo>.from(
        json.decode(str).map((x) => FrequentMessagesInfo.fromJson(x)));

String frequentMessagesInfoToJson(List<FrequentMessagesInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FrequentMessagesInfo {
  FrequentMessagesInfo({
    this.tags,
    this.content,
  });

  String tags;
  String content;

  factory FrequentMessagesInfo.fromJson(Map<String, dynamic> json) =>
      FrequentMessagesInfo(
        tags: json['tags'],
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        'tags': tags,
        'content': content,
      };
}

Future<List<FrequentMessagesInfo>> getFrequent() async {
  // cambiar esto por llamada local
  var askForFrequentMessages =
      await rootBundle.loadString('assets/frequentMessagesInfo.json');

  List frequentMessageInfo =
      frequentMessagesInfoFromJson(askForFrequentMessages);

  return frequentMessageInfo;
}
