import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chat_list.dart';
import '../components/adaptive_page_layout.dart';
import '../components/content_banner.dart';
import '../components/dialogs/simple_dialogs.dart';
import '../components/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    final _baseUrl = dotenv.env['APISERVER'];
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
              background: ContentBanner(
                Uri.https(
                    _baseUrl, 'appenia/enia-assets/images/trama-mds-lila.png'),
                height: 300,
                //defaultIcon: Icons.account_circle,
                loading: profile == null,
                //onEdit: () => setAvatarAction(context),
              ),
            ),
          ),
        ],
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                'Acceso a las propuestas de capacitación y a las grabaciones de webinarios y videos educativos.',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.description),
              title: Text(
                'Conocé las propuestas de capacitación',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1xBvRQHT_39olEBT7P-EV5EuVzIiZ9jQD/view?usp=sharing'),
            ),
            ListTile(
              title: Text(
                'Te podés capacitar con estos videos',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(''),
            ),
            ListTile(
              title: Text(
                'Serie audiovisual para la formación en detección y abordaje del abuso sexual y el embarazo forzado en la niñez y adolescencia - 2021',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              contentPadding: EdgeInsets.fromLTRB(14.0, 8.0, 0.0, 0.0),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text('Detección temprana en salud'),
              onTap: () => launch('https://youtu.be/Bq_N7qyV4wU'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text('Detección temprana en las escuelas'),
              onTap: () => launch('https://youtu.be/ttUdfij5HCU'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text('La consejería en derechos'),
              onTap: () => launch('https://youtu.be/g-H2N1sCLBA'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text('Hoja de ruta'),
              onTap: () => launch('https://youtu.be/G9_w54X2Epo'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text('El rol del sistema de protección'),
              onTap: () => launch('https://youtu.be/c6Xgej97JiY'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text('Aportes para su comprensión y abordaje'),
              onTap: () => launch('https://youtu.be/r9Iresw0M8k'),
            ),
            ListTile(
              title: Text(
                'Ciclo de Encuentros para un abordaje intersectorial de niñas y adolescentes menores de 15 años con embarazos forzados - 2020',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              contentPadding: EdgeInsets.fromLTRB(14.0, 8.0, 0.0, 0.0),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Presentación Hoja de ruta de Atención de niñas y adolescentes menores de 15 embarazadas'),
              subtitle: Text('Duración: 21:16 minutos'),
              onTap: () => launch('https://youtu.be/rba_rWjE-b4'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Experiencias de atención integral de niñas y adolescentes de menores de 15 años víctimas de abuso sexual y embarazo forzado, una mirada federal. Experiencias de Jujuy y Entre Ríos'),
              subtitle: Text('Duración: 21:16 minutos'),
              onTap: () => launch('https://youtu.be/EljwCJPkjWo'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Experiencias de atención integral de niñas y adolescentes de menores de 15 años víctimas de abuso sexual y embarazo forzado, una mirada federal. Experiencias de Mendoza y Chubut'),
              subtitle: Text('Duración: 18:21 minutos'),
              onTap: () => launch('https://youtu.be/0AlQa8XO88U'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Experiencias, herramientas y desafíos de la ESI para el abordaje de abusos sexuales y embarazos forzados en niñas y adolescentes menores de 15 años'),
              subtitle: Text('Duración: 14 minutos'),
              onTap: () => launch('https://youtu.be/I4eT9BiCD_0'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'La importancia del abordaje integral y el acceso a la justicia en casos de abusos sexuales y embarazos forzados'),
              subtitle: Text('Duración: 15 minutos'),
              onTap: () => launch('https://youtu.be/LrwgDdSHnn0'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Abusos sexuales y embarazos forzados. Caracterización y orientaciones para un abordaje con enfoque de género y generacional (Parte 1)'),
              subtitle: Text('Duración: 15 minutos'),
              onTap: () => launch('https://youtu.be/CennNuTQtLs'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Abusos sexuales y embarazos forzados. Caracterización y orientaciones para un abordaje con enfoque de género y generacional (Parte 2)'),
              subtitle: Text('Duración: 15 minutos'),
              onTap: () => launch('https://youtu.be/-F4PjveyZOg'),
            ),
            /* ListTile(
              title: Text(
                'Webinarios realizados en el marco del curso "Anticoncepción en las adolescencias" - 2020',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              contentPadding: EdgeInsets.fromLTRB(14.0, 8.0, 0.0, 0.0),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Webinario: Protocolo para la atención integral de personas con derecho a la ILE, con énfasis en la asistencia a NNyA'),
              subtitle: Text('Duración: 1:01 horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=ZJfqGXmp7to'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Webinario: Respuestas y desafíos de las políticas frente al abuso sexual y embarazo forzado'),
              subtitle: Text('Duración: 1:45 horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=yVUopxQEa0M'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Webinario: Anticoncepción y modelo social de la discapacidad'),
              subtitle: Text('Duración: 1:31 horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=quQ1KhriWwM'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Webinario: Fortalecimiento de la perspectiva de diversidad sexual y corporal en el modelo de atención en salud'),
              subtitle: Text('Duración: 1:24 Horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=1eofLLleDbE'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text('Webinario: Adolescencias, vínculos y violencias'),
              subtitle: Text('Duración: 1:24 Horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=IKIvGorudbw'),
            ), */
            ListTile(
              title: Text(
                'Encuentros de actualización profesional sobre Interrupción Legal del Embarazo - 2020',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              contentPadding: EdgeInsets.fromLTRB(14.0, 8.0, 0.0, 0.0),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Causal salud, de la teoría la práctica Claves para su implementación'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () => launch('https://youtu.be/JySIzVDU6bk'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Ruta crítica para las niñas y adolescentes embarazadas menores de 15 años'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () => launch('https://youtu.be/LM0e0yLM2AE'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text('Aborto en 13 semanas y más'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () => launch('https://youtu.be/BneNJSW7ZWA'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Implementación y manejo de la Aspiración Manual Endouterina AMEU'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () => launch('https://youtu.be/gLS7QHlgamc'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Uso y manejo de misoprostol para el aborto con medicamentos hasta las 12 semanas'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () => launch('https://youtu.be/rs5g89gxjJU'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Atención integral en la interrupción legal del embarazo'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () => launch('https://youtu.be/njsC2Qa95u4'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Protocolo para la atención integral de las personas con derecho a la interrupción legal del embarazo'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () => launch('https://youtu.be/syJzbk3jnKg'),
            ),
          ],
        ),
      ),
    );
  }
}
