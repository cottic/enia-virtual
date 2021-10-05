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
                              'Contiene información de la cantidad de adolescentes asesoradas/es/os) en los departamentos priorizados por el Plan Enia. Se contabilizan las/es/os adolescentes asesoradas/es/os como quienes recibieron al menos un asesoramiento (individual o grupal) en un año calendario. De esta forma la cantidad de adolescentes es menor o igual a la cantidad de asesoramientos brindados 1. ',
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
                                'La tarjeta “Adolescentes asesorades” cuenta la cantidad de adolescentes que recibieron al menos un asesoramiento en la jurisdicción y el período seleccionados.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                'La tarjeta “% de cobertura de matrícula” muestra la proporción de adolescentes asesoradas/es/os sobre la matrícula total de escuelas secundarias de los departamentos priorizados Enia, según información de la DIEE (Dirección de Información y Estadística Educativa. Ministerio de Educación de la Nación) al 2019, última información disponible, en la jurisdicción y el período seleccionados.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                'La tarjeta “% de individuales” muestra la proporción de adolescentes asesoradas/es/os en modalidad individual sobre el total de adolescentes asesoradas/es/os en la jurisdicción  y el período seleccionados.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                'La tarjeta “% de grupales” muestra la proporción de adolescentes asesoradas/es/os en modalidad grupal (dos a cinco adolescentes) sobre el total de adolescentes asesoradas/es/os en la jurisdicción  y el período seleccionados.'),
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
                                '“Adolescentes por tipo de localización y jurisdicción”: Datos en valores absolutos. Se presenta la cantidad de adolescentes asesoradas/es/os según tipo de localización (escuelas, servicios de salud, espacios comunitarios) y modalidad virtual por jurisdicción en el período selecionado. '),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                '“Adolescentes por tipo de localización”: Distribución porcentual de adolescentes asesoradas/es/os en asesoramientos individuales y grupales según tipo de localización y modalidad virtual en la jurisdicción y el período seleccionados.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(
                                '“Evolución mensual de adolescentes por tipo de localización”: Datos en valores absolutos. Presenta la evolución mensual de adolescentes asesoradas/es/os en asesoramientos individuales y grupales según tipo de localización y modalidad virtual en la jurisdicción y el período seleccionados.'),
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
                                'Los tableros permiten seleccionar períodos de tiempo de un mes o mayores y también seleccionar jurisdicciones: total Enia, provincia o departamento. El inicio del reporte de asesoramientos individuales y grupales fue: Misiones marzo de 2018; Jujuy abril de 2018; Corrientes, Salta y Tucumán en junio 2018; Entre Ríos julio 2018; Buenos Aires y Chaco octubre de 2018; y Catamarca, La Rioja y Santiago del Estero mayo 2019.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            title: Text(
                                'Notas: 1 La provincia de Formosa no cuenta con dispositivos ASIE.'),
                            subtitle: Text(''),
                          ),
                          ListTile(
                            title: Text(
                                'Fuente: Planilla B ASIE, Monitoreo Enia. DNSSR, SAS, Ministerio de Salud de la Nación.'),
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
