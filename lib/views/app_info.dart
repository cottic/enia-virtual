import 'package:fluffychat/components/adaptive_page_layout.dart';
import 'package:fluffychat/components/matrix.dart';
import 'package:fluffychat/l10n/l10n.dart';
import 'package:fluffychat/views/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:olm/olm.dart' as olm;
import 'package:fluffychat/utils/beautify_string_extension.dart';

class AppInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.SECOND,
      firstScaffold: ChatList(),
      secondScaffold: AppInfo(),
    );
  }
}

class AppInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var client = Matrix.of(context).client;
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context).accountInformations),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(L10n.of(context).yourOwnUsername + ':'),
            subtitle: Text(client.userID),
          ),
          ListTile(
            title: Text('Homeserver:'),
            subtitle: Text(client.homeserver.toString()),
          ),
          ListTile(
            title: Text('Device name:'),
            subtitle: Text(client.deviceName),
          ),
          ListTile(
            title: Text('Device ID:'),
            subtitle: Text(client.deviceID),
          ),
          ListTile(
            title: Text('Encryption enabled:'),
            subtitle: Text(client.encryptionEnabled.toString()),
          ),
          if (client.encryptionEnabled)
            Column(
              children: <Widget>[
                ListTile(
                  title: Text('Your public fingerprint key:'),
                  subtitle: Text(client.fingerprintKey.beautified),
                ),
                ListTile(
                  title: Text('Your public identity key:'),
                  subtitle: Text(client.identityKey.beautified),
                ),
                ListTile(
                  title: Text('LibOlm version:'),
                  subtitle: Text(olm.get_library_version().join('.')),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
