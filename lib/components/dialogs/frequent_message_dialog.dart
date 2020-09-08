import 'dart:async';
import 'package:fluffychat/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class FrequentMessageDialog extends StatefulWidget {
  final Function onFinished;

  const FrequentMessageDialog({this.onFinished, Key key}) : super(key: key);

  @override
  _FrequentMessageDialogState createState() => _FrequentMessageDialogState();
}

class _FrequentMessageDialogState extends State<FrequentMessageDialog> {
  bool error = false;
  List<FrequentMessagesInfo> respuestasFrecuentes;

  @override
  void initState() {
    super.initState();

    respuestasFrecuentes = [
      FrequentMessagesInfo(
        tags: '#enia #video',
        content:
            'Si queres conocer más sobre el plan, mira https://www.youtube.com/watch?v=Gl-Temz2HKA',
      ),
      FrequentMessagesInfo(
        tags: '#mac #anticoncepcion #metodosanticonceptivos',
        content:
            'Existen métodos anticonceptivos gratuitos. Así lo establece la ley nacional 25.673. Podés pedirlos en centros de salud y/u hospitales y también se deben entregar gratis a través de obras sociales y prepagas. Hay varias opciones. El mejor método anticonceptivo es el que vos elegís, el que mejor se adapta a tus necesidades y convicciones. El preservativo es el único método que te protege de infecciones de transmisión sexual y el VIH/SIDA.',
      ),
      FrequentMessagesInfo(
        tags: '#AHE  #pastilladeldiadespues',
        content:
            'Es un método anticonceptivo que se utiliza después de una relación sexual sin protección: si no usaste otro método anticonceptivo o falló el que estabas usando. También se usa en caso de una violación sexual. Es de emergencia porque es la última opción para prevenir un embarazo. Es menos efectiva que los métodos de uso habitual y sólo protege en esa relación sexual. Es mejor cuanto antes la tomes. Especialmente dentro de las primeras 12 horas. Podés tomarla hasta cinco días después, pero disminuye la efectividad. La anticoncepción de emergencia retrasa la ovulación y espesa el moco cervical uterino. Así evita que se junten el óvulo y el espermatozoide. Si el ovulo y el espermatozoide ya se unieron las pastillas no tienen efecto y el embarazo continúa. Sin ningún daño para el embrión. No son abortivas. Viene en dos presentaciones: de una o dos pastillas. Las podés retirar sola/o o en pareja en hospitales públicos o centros de salud. No tenes que ser mayor de edad. No pueden exigirte ningún requisito. No tiene contraindicaciones y tenés derecho a recibirla todas las veces que la solicites. No protege del VIH/Sida ni de otras infecciones de transmisión sexual. Los anticonceptivos son gratuitos. Así lo establece la ley nacional 25.673. Pedilos en centros de salud y hospitales. También se entregan gratis a través de obras sociales y prepagas.',
      ),
      FrequentMessagesInfo(
        tags: '#derechos #saludadolescentes',
        content:
            'Las/os/es adolescentes tienen derecho a ser atendidas/os/es, a recibir información y al respeto de su confidencialidad en el sistema de salud. A partir de los 13 años las/os adolescentes tienen derecho a recibir el método anticonceptivo que elijan aunque no estén acompañados por un mayor de edad. Las personas menores de 13 años tienen derecho a ser escuchadas. A recibir información y asesoramiento. Y acceder a preservativos de manera gratuita. A partir de los 16 años tienen capacidad plena para la toma de decisiones sobre el cuidado del propio cuerpo como personas adultas.',
      )
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(bottom: 10, left: 5, top: 6),
              child: Text(
                //TODO: internazionalizar texto
                'Seleccione una respuesta:',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: <Widget>[
                        _createItemRespuesta(
                            context, respuestasFrecuentes[index]),
                      ],
                    );
                  } else {
                    return _createItemRespuesta(
                        context, respuestasFrecuentes[index]);
                  }
                },
                itemCount: respuestasFrecuentes.length,
              ),
            ),
            FlatButton(
              child: Text(
                L10n.of(context).cancel.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .color
                      .withAlpha(150),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
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
        onTap: () {
          final result = respuestaItem.content.toString();
          if (widget.onFinished != null) {
            widget.onFinished(result);
          }
          Navigator.of(context).pop();
        },
      ),
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
