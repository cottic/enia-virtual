import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chat_list.dart';
import '../components/adaptive_page_layout.dart';
import '../components/dialogs/simple_dialogs.dart';
import '../components/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class LibraryEniaMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.SECOND,
      firstScaffold: ChatList(),
      secondScaffold: LibraryEniaMenu(),
    );
  }
}

class LibraryEniaMenu extends StatefulWidget {
  @override
  _LibraryEniaMenuState createState() => _LibraryEniaMenuState();
}

class _LibraryEniaMenuState extends State<LibraryEniaMenu> {
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
                'Biblioteca',
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
                'Materiales para abordar las temáticas relativas al Plan: educación sexual integral, salud sexual y salud reproductiva, derechos y salud adolescente.',
              ),
            ),
            ListTile(
              title: Text(
                'Educación sexual integral',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'El Embarazo No Intencional en la Adolescencia - 	Contenidos de Educación Sexual Integral'),
              subtitle: Text('Propuestas para el aula - Nivel Secundario'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1aPsgjFIlPcETvQ2E-DRu8bhk1Ra86OPl/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Cuadernillo ESI para Educación Secundaria I'),
              subtitle: Text('Contenidos y propuestas para el aula'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1htgQZ1qhL9nipXspXcnXnOUL8Roamh6T/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Cuadernillo ESI para Educación Secundaria II '),
              subtitle: Text('Contenidos y propuestas para el aula'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/13tTxQHaEaiqC7ssC9iDZ59HQnqsgfW7k/view?usp=sharing'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Salud sexual y reproductiva',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Adolescencias, derechos y salud',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Prevención del Embarazo Forzado y del Abuso Sexual contra NNYA',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(thickness: 1),
          ],
        ),
      ),
    );
  }
}
