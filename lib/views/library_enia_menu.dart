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
                'Periódicos y Redes',
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
                'Descripción: Información de interés para la comunidad Enia. Un espacio con las novedades e insumos para los equipos que conforman el Plan.',
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Guía de Fortalecimiento para los territorios digitales'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1H8AKdyL8kYyqXttsUcoprbxTh7Qe6Iwk/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico Plan Enia marzo 2021'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1lap_GLeSuGt_JWMRmKeNmQWL8h_MOYXT/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico Plan Enia febrero 2021'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1Bk7Zjb_ef1N_y7m_Ic7xXIzMbpYXV1JP/view?usp=sharing'),
            ),
            /* -------------------------------------------- */
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico Plan Enia enero 2021'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1xqSS8iZ8tcLcJAS1yufqC52wGHp269EM/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico Plan Enia diciembre 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1I9xC-e4BR3VGXHwQGC-Bj_gyB56s8dx-/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico Plan Enia noviembre 2020'),
              subtitle: Text(''),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico Plan Enia octubre 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1trsl-SjJMfdl6iLi0ZP10bk3XzGMR0PO/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico Plan Enia septiembre 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1ICM3JsBB20Dy-vFcpit77MyYbgaWEo9I/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico Plan Enia agosto 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1DI--C7gu-1-nrEdpxsb-WDgXVYesm8IB/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico Plan Enia julio 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1tJbacOhCOqWNiv6e7m2blI7GTZ1W7lcK/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico Plan Enia junio 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/17y88gmWT1kaK3hlRKMucfhKhtvtR0DO_/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico Plan Enia mayo 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/13RNM5VLGW9wz8kA9HE6o9L0150COHUWc/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico Plan Enia abril 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1pR98_6hwy1Srr8KMa7wjm-egTEY5TYlq/view?usp=sharing'),
            ),
          ],
        ),
      ),
    );
  }
}
