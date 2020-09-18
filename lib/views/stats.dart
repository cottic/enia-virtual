import 'package:famedlysdk/famedlysdk.dart';
import 'package:fluffychat/components/adaptive_page_layout.dart';
import 'package:fluffychat/components/list_items/chat_list_item.dart';
import 'package:fluffychat/components/matrix.dart';
import 'package:fluffychat/l10n/l10n.dart';
import 'package:flutter/material.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  List<Room> archive;

  /* Future<List<Room>> getArchive(BuildContext context) async {
    if (archive != null) return archive;
    return await Matrix.of(context).client.archive;
  } */

  Future<List<Room>> getStats(BuildContext context) async {
    if (archive != null) return archive;
    return await Matrix.of(context).client.archive;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      firstScaffold: Scaffold(
        appBar: AppBar(
          title: Text('Estadisticas'),
        ),
        body: FutureBuilder<List<Room>>(
          future: getStats(context),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              archive = snapshot.data;
              return ListView.builder(
                itemCount: archive.length,
                itemBuilder: (BuildContext context, int i) => ChatListItem(
                    archive[i],
                    onForget: () => setState(() => archive.removeAt(i))),
              );
            }
          },
        ),
      ),
      secondScaffold: Scaffold(
        body: Center(
          child: Image.asset('assets/logo.png', width: 100, height: 100),
        ),
      ),
      primaryPage: FocusPage.FIRST,
    );
  }
}
