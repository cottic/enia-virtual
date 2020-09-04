import 'dart:async';
import 'package:fluffychat/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FrequentMessageDialog extends StatefulWidget {
  final Function onFinished;

  const FrequentMessageDialog({this.onFinished, Key key}) : super(key: key);

  @override
  _FrequentMessageDialogState createState() => _FrequentMessageDialogState();
}

class _FrequentMessageDialogState extends State<FrequentMessageDialog> {

  bool error = false;
  Future<List<FrequentMessagesInfo>> respuestasFrecuentes;

  @override
  void initState() {
    super.initState();
    respuestasFrecuentes = getFrequentMessagesInfo();
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
            FutureBuilder<List<FrequentMessagesInfo>>(
              future: respuestasFrecuentes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          children: <Widget>[
                            _createItemRespuesta(context, snapshot.data[index]),
                          ],
                        );
                      } else {
                        return _createItemRespuesta(
                            context, snapshot.data[index]);
                      }
                    },
                    itemCount: snapshot.data.length,
                  ));
                } else if (snapshot.hasError) {
                  return Text(snapshot.error);
                }
                return CircularProgressIndicator();
              },
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
            style: Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).accentColor),
          ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top:8.0),
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

  Future<List<FrequentMessagesInfo>> getFrequentMessagesInfo() async {
    final response = await http
        .get('http://proyecto.codigoi.com.ar/appenia/mensajesfrecuentes.json');

    if (response.statusCode == 200) {
      var _source = Utf8Decoder().convert(response.bodyBytes);
      List frequentMessageInfo = frequentMessagesInfoFromJson(_source);

      return frequentMessageInfo;
    } else {
      throw Exception('Failed to load info');
    }
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
