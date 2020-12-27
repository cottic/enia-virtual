import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
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
                  child:CircularProgressIndicator(),
                );
              case ConnectionState.active:
                return Center(
                  child:CircularProgressIndicator(),
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
                            L10n.of(context).pickAnswer,
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
                                      context, snapshot.data[index]),
                                ],
                              );
                            } else {
                              return _createItemRespuesta(
                                  context, snapshot.data[index]);
                            }
                          },
                          itemCount: snapshot.data.length,
                        )),
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
