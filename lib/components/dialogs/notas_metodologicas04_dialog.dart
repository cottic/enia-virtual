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
                              'Se muestra el total de LARC1 distribuidos desde el Ministerio de Salud de la Nación a depósitos de programas provinciales y desde estos depósitos provinciales a servicios de salud; así como el total de LARC (implantes subdérmicos y DIU) dispensados a población objetivo del Plan -menores de 20 años- y población de 20 años y más. También se contabiliza el total de efectores de salud que informaron dispensa de LARC a esa población.',
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
                                'La tarjeta “A depósitos provinciales” muestra el total de LARC distribuidos desde el Ministerio de Salud de la Nación a depósitos de programas provinciales en la jurisdicción (provincia) y el período seleccionados.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                'La tarjeta “A servicios de salud” muestra la cantidad de LARC distribuidos desde los depósitos de los programas provinciales a los servicios de salud en la jurisdicción y el período seleccionados.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                'La tarjeta “Dispensados” muestra la cantidad de LARC dispensada en departamentos priorizados por el Plan en la jurisdicción y el período seleccionados.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                'La tarjeta “Efectores involucrados” cuenta la cantidad de servicios de salud que informaron esa dispensa de LARC en departamentos priorizados por el Plan en la jurisdicción y el período seleccionados.'),
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
                                '“Distribución y dispensa de LARC por jurisdicción”: presenta en valores absolutos, la cantidad de LARC que fueron distribuidos a depósitos de programas provinciales, a servicios de salud y dispensados por jurisdicción en el período seleccionado. La cantidad de LARC distribuidos desde el Ministerio de Salud de la Nación a depósitos provinciales se mantiene constante cuando se seleccionan distintos departamentos de una misma provincia por ser un dato de nivel provincial.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                '“Distribuidos según método”: presenta en porcentaje la proporción distribuida desde el Ministerio de Salud de la  Nación a depósitos provinciales por tipo de LARC: Implantes subdérmicos y DIU en la jurisdicción y el período seleccionados.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                '“Evolución anual de la distribución y dispensa”: presenta en valores absolutos la cantidad de LARC distribuidos a depósitos provinciales, servicios de salud y los dispensados en departamentos priorizados por el Plan en la jurisdicción y el período seleccionados. '),
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
                                'Notas: 1 1 Los LARC (métodos anticonceptivos reversibles de larga duración en su sigla en inglés: Long-acting reversible contraception) incluyen implantes subdérmicos y DIU. '),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            title: Text(
                                'Fuente: Planilla dispensa de LARC, Planilla B, Base de actividades mensuales ESI, Base de agentes de SSR capacitadas/es/os y Base de docentes y directivas/es/os capacitadas/es/os Monitoreo Enia. DNSSR, SAS, Ministerio de Salud de la Nación.'),
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

  Widget _createItemRespuesta(
      BuildContext context, FrequentMessagesInfo respuestaItem) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          respuestaItem.tags,
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(color: Theme.of(context).accentColor),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(respuestaItem.content),
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
