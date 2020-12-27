import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chat_list.dart';
import '../components/adaptive_page_layout.dart';
import '../components/dialogs/simple_dialogs.dart';
import '../components/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class FormationEniaMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.SECOND,
      firstScaffold: ChatList(),
      secondScaffold: FormationEniaMenu(),
    );
  }
}

class FormationEniaMenu extends StatefulWidget {
  @override
  _FormationEniaMenuState createState() => _FormationEniaMenuState();
}

class _FormationEniaMenuState extends State<FormationEniaMenu> {
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
                'Capacitaciones',
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
                'Un espacio para el fortalecimiento institucional. Todos los enlaces de ingreso: capacitaciones virtuales, webinarios y grabaciones de programas y encuentros de trabajo.',
              ),
            ),
            ListTile(
              trailing: Icon(Icons.description),
              title: Text('Capacitaciones en curso y en inscripción'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://docs.google.com/document/d/1xQyxputekLdix4cM6Fu4GDXHyEgOoIeS5bes7llhzQo/edit?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.description),
              title: Text('Oferta de propuestas de capacitación'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1y-hX11hK0Pb5QmYvaE30yRv5oBs83cVr/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                'Registros de las capacitaciones y webinarios realizados',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Curso del Plan Nacional de Prevención del Embarazo no intencional en la Adolescencia (ENIA)'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1shT3jaWGqRPYrDBIjyHDfzAdADx-RRJ3/view?usp=sharing'),
            ),
          ],
        ),
      ),
    );
  }
}
