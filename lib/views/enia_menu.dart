import 'package:flutter/material.dart';

import 'chat_list.dart';
import '../components/adaptive_page_layout.dart';
import '../components/dialogs/simple_dialogs.dart';
import '../components/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class EniaMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.SECOND,
      firstScaffold: ChatList(),
      secondScaffold: EniaMenu(),
    );
  }
}

class EniaMenu extends StatefulWidget {
  @override
  _EniaMenuState createState() => _EniaMenuState();
}

class _EniaMenuState extends State<EniaMenu> {
  Future<dynamic> profileFuture;
  dynamic profile;
  Future<bool> crossSigningCachedFuture;
  bool crossSigningCached;
  Future<bool> megolmBackupCachedFuture;
  bool megolmBackupCached;
  String bullet = '\u2022';

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
                'Enia@virtual',
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
                  'Enia@virtual ofrece un medio de comunicación para la comunidad del Plan Enia y una modalidad de trabajo con énfasis en el fortalecimiento de las capacidades de sus agentes. Aquí encontrarás espacios para comunicarte con tus compañeras/os/es de las diferentes provincias y departamentos, podrás consultar documentos técnicos para llevar adelante tu tarea, participar en capacitaciones virtuales y hacer consultas a los tableros y mapas para analizar el desempeño del Plan en tu provincia, escuela, servicios de salud o espacio comunitario.'),
            ),
            ListTile(
              title: Text(
                  'Además Enia@virtual ofrece a las/os/es asesoras/es del dispositivo de asesorías en salud integral en escuelas secundarias un medio de comunicación directa con las/os/es adolescentes que consultan.'),
            ),
            /*
            Divider(thickness: 1),
            ListTile(
              title: Text(
                '¿Qué nos proponemos?',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(bullet +
                  ' Sensibilizar sobre la importancia de prevenir el embarazo no intencional en la adolescencia.'),
            ),
            ListTile(
              title: Text(bullet +
                  ' Potenciar el ejercicio de los derechos sexuales y reproductivos en la adolescencia.'),
            ),
            ListTile(
              title: Text(bullet +
                  ' Brindar información sobre salud sexual y reproductiva y métodos anticonceptivos en forma gratuita en los servicios de salud.'),
            ),
            ListTile(
              title: Text(bullet +
                  ' Fortalecer políticas para la prevención del abuso, la violencia sexual y el acceso a la interrupción legal del embarazo según el marco normativo vigente.'),
            ), */
          ],
        ),
      ),
    );
  }
}
