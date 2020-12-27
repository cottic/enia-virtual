import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'chat_list.dart';
import '../components/adaptive_page_layout.dart';
import '../components/dialogs/simple_dialogs.dart';
import '../components/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class FilesEniaMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.SECOND,
      firstScaffold: ChatList(),
      secondScaffold: FilesEniaMenu(),
    );
  }
}

class FilesEniaMenu extends StatefulWidget {
  @override
  _FilesEniaMenuState createState() => _FilesEniaMenuState();
}

class _FilesEniaMenuState extends State<FilesEniaMenu> {
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
                'Documentos',
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
                'Documentos técnicos',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Implementación del Plan Nacional ENIA	'),
              subtitle: Text(
                  'Documento técnico N°2 - Julio 2018 - Modalidad de Intervención y dispositivos'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/implementacion_del_plan_nacional_enia_documento_tecnico_ndeg2_-_julio_2018_-_modalidad_de_intervencion_y_dispositivos.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Sistema de Monitoreo Plan ENIA	'),
              subtitle: Text('Documento técnico Nº 7 - Noviembre 2019'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/cuadernillo_esi_para_educacion_secundaria_i.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('El Plan ENIA y la perspectiva de la discapacidad'),
              subtitle: Text('Documento técnico Nº 3 - Marzo 2019'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/el_plan_enia_y_la_perspectiva_de_la_discapacidad.documento_tecnico_no_3-_marzo_2019.pdf'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Estudios técnicos',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Consecuencias socioeconómicas del embarazo en la adolescencia en Argentina. '),
              subtitle: Text('Resumen ejecutivo'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/estudios_tecnicos_-_consecuencias_socioeconomicas_del_embarazo_en_la_adolescencia_en_argentina.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Consecuencias socioeconómicas del embarazo en la adolescencia en Argentina. '),
              subtitle: Text('Informe final.'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/consecuencias_socioeconomicas_del_embarazo_en_la_adolescencia_en_argentina._informe_final.pdf'),
            ),
            
          ],
        ),
      ),
    );
  }
}
