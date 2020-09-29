import 'dart:io';

import 'package:famedlysdk/famedlysdk.dart';
import 'package:fluffychat/components/settings_themes.dart';
import 'package:fluffychat/views/settings_devices.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memoryfilepicker/memoryfilepicker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_info.dart';
import 'chat_list.dart';
import '../components/adaptive_page_layout.dart';
import '../components/dialogs/simple_dialogs.dart';
import '../components/content_banner.dart';
import '../components/matrix.dart';
import '../l10n/l10n.dart';
import '../utils/app_route.dart';
import 'settings_emotes.dart';

class StatsEniaMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.SECOND,
      firstScaffold: ChatList(),
      secondScaffold: StatsEniaMenu(),
    );
  }
}

class StatsEniaMenu extends StatefulWidget {
  @override
  _StatsEniaMenuState createState() => _StatsEniaMenuState();
}

class _StatsEniaMenuState extends State<StatsEniaMenu> {
  Future<dynamic> profileFuture;
  dynamic profile;
  Future<bool> crossSigningCachedFuture;
  bool crossSigningCached;
  Future<bool> megolmBackupCachedFuture;
  bool megolmBackupCached;

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
              title: Text(
                'Estadisticas',
                style: TextStyle(color: Theme.of(context).backgroundColor),
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
                'Objetivo general Estadisticas',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
                trailing: Icon(Icons.help),
                title: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                onTap: () {}
                //=> launch(
                //TODO: poner url final
                //  'https://github.com/cottic/enia-virtual/'),
                ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Fundamentos',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
                trailing: Icon(Icons.help),
                title: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                onTap: () {}
                //=> launch(
                //TODO: poner url final
                //  'https://github.com/cottic/enia-virtual/'),
                ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                L10n.of(context).about,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
                trailing: Icon(Icons.help),
                title: Text(L10n.of(context).help),
                onTap: () {}
                //=> launch(
                //TODO: poner url final
                //  'https://github.com/cottic/enia-virtual/'),
                ),
            ListTile(
              trailing: Icon(Icons.link),
              title: Text(L10n.of(context).license),
              onTap: () => launch(
                  'https://github.com/cottic/enia-virtual/blob/master/LICENSE'),
            ),
            ListTile(
              trailing: Icon(Icons.code),
              title: Text(L10n.of(context).sourceCode),
              onTap: () => launch('https://github.com/cottic/enia-virtual'),
            ),
          ],
        ),
      ),
    );
  }
}
