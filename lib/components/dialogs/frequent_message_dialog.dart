import 'dart:async';
import 'package:fluffychat/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FrequentMessageDialog extends StatefulWidget {
  final Function onFinished;

  const FrequentMessageDialog({this.onFinished, Key key}) : super(key: key);

  @override
  _FrequentMessageDialogState createState() => _FrequentMessageDialogState();
}

class _FrequentMessageDialogState extends State<FrequentMessageDialog> {
  List<RespuestaItem> respuestasFrecuentes;

  bool error = false;

  @override
  void initState() {
    super.initState();
    //startRecording();
    respuestasFrecuentes = [
      RespuestaItem(
        tags: '#anticonceptivos #prevencion #preservativo',
        respuesta:
            'Lorem aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      ),
      RespuestaItem(
        tags: '#anticonceptivos #prevencion #preservativo',
        respuesta:
            'Lorem ore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      ),
      RespuestaItem(
        tags: '#anticonceptivos #prevencion #preservativo',
        respuesta:
            'Lorem aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      ),
      RespuestaItem(
        tags: '#anticonceptivos #prevencion #preservativo',
        respuesta:
            'Lorem ore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
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
        height: 400,
        child: Column(
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
            Container(
              height: 310,
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
      BuildContext context, RespuestaItem respuestaItem) {
    return Card(
     // color: Colors.blue[200],
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(respuestaItem.respuesta),
        subtitle: Text(
          respuestaItem.tags,
          style: Theme.of(context).textTheme.caption,
          //style:TextStyle(color: Colors.deepPurple, fontStyle: FontStyle.italic),
        ),
        onTap: () {
          final result = respuestaItem.respuesta.toString();
          if (widget.onFinished != null) {
            widget.onFinished(result);
          }
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class RespuestaItem {
  RespuestaItem({
    this.tags,
    this.respuesta,
  });

  String tags;
  String respuesta;

  factory RespuestaItem.fromJson(Map<String, dynamic> json) => RespuestaItem(
        tags: json['tags'],
        respuesta: json['respuesta'],
      );

  Map<String, dynamic> toJson() => {
        'tags': tags,
        'respuesta': respuesta,
      };
}
