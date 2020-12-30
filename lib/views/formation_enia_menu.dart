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
                  'El Plan Enia apuesta al fortalecimiento de las capacidades de quienes lo componen. Podrás acceder aquí a los enlaces de ingreso a las capacitaciones virtuales (en curso); y a los programas y grabaciones de encuentros y webinarios.'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Curso virtual Plan Enia'),
              subtitle: Text(
                  'El curso del Plan Nacional de Prevención del Embarazo no Intencional en la Adolescencia tiene como propósito fortalecer la implementación del Plan a través de una apuesta al compromiso de la acción intersectorial con un enfoque de derechos y perspectiva de género.'),
              onTap: () => launch(
                  'http://www.codigoi.com.ar/uploads/2020/12/Curso-virtual-Plan-Enia.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Protocolo para la atención integral de las personas con derecho a la interrupción legal del embarazo'),
              subtitle: Text(
                  'Elaborado por la DNSSyR en base al ciclo "Encuentros de actualización profesional sobre interrupción legal del embarazo - 2020"'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=LZEf3QtU1wI'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Atención integral en la interrupción legal del embarazo'),
              subtitle: Text(
                  'Elaborado por la DNSSyR en base al ciclo "Encuentros de actualización profesional sobre interrupción legal del embarazo - 2020"'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=3Ljz6QB4G8M'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Uso y manejo de misoprostol para el aborto con medicamentos hasta las 12 semanas'),
              subtitle: Text(
                  'Elaborado por la DNSSyR en base al ciclo "Encuentros de actualización profesional sobre interrupción legal del embarazo - 2020"'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=jcvXbbP1wDw'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Implementación y manejo de la Aspiración Manual Endouterina AMEU'),
              subtitle: Text(
                  'Elaborado por la DNSSyR en base al ciclo "Encuentros de actualización profesional sobre interrupción legal del embarazo - 2020"'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=RPKLMu72yIw'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text('Aborto en 13 semanas y más'),
              subtitle: Text(
                  'Elaborado por la DNSSyR en base al ciclo "Encuentros de actualización profesional sobre interrupción legal del embarazo - 2020"'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=i44iOhXglUk'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Ruta crítica para las niñas y adolescentes embarazadas menores de 15 años'),
              subtitle: Text(
                  'Elaborado por la DNSSyR en base al ciclo "Encuentros de actualización profesional sobre interrupción legal del embarazo - 2020"'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=LQobVCJkXjw'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Causal salud, de la teoría la práctica Claves para su implementación'),
              subtitle: Text(
                  'Elaborado por la DNSSyR en base al ciclo "Encuentros de actualización profesional sobre interrupción legal del embarazo - 2020"'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=yOck9YXBF6Y'),
            ),
          ],
        ),
      ),
    );
  }
}
