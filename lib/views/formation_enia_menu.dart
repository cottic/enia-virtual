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
              title: Text(
                'Conocé las propuestas de capacitación',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1xBvRQHT_39olEBT7P-EV5EuVzIiZ9jQD/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.description),
              title: Text(
                'Te podés capacitar con estos videos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(''),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Registros de las capacitaciones y webinarios realizados',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Ciclo de Encuentros para un abordaje intersectorial de niñas y adolescentes menores de 15 años con embarazos forzados - 2020',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                  'Nota aclaratoria: Al momento de producción de estos videos no se encontraba sancionada la ley 27.610 que regula el acceso a la Interrupción Voluntaria y Legal del Embarazo y la atención post aborto de las adolescentes, mujeres y personas con capacidad de gestar. A partir de esta ley se reconoce el derecho a la interrupción voluntaria del embarazo (IVE) hasta la semana 14 inclusive y se mantiene el derecho a la interrupción legal del embarazo (ILE) por las causales: peligro para la vida o la salud de la persona gestante y/o violación.'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '1.- Presentación Hoja de ruta de Atención de niñas y adolescentes menores de 15 embarazadas'),
              subtitle: Text('Duración: 21:16 minutos'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=kJiU4NUg8pE'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '2.- Experiencias de atención integral de niñas y adolescentes de menores de 15 años víctimas de abuso sexual y embarazo forzado, una mirada federal. Experiencias de Jujuy y Entre Ríos'),
              subtitle: Text('Duración: 21:16 minutos'),
              onTap: () => launch('https://youtu.be/qL2xlvasHgE'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '3.- Experiencias de atención integral de niñas y adolescentes de menores de 15 años víctimas de abuso sexual y embarazo forzado, una mirada federal. Experiencias de Mendoza y Chubut'),
              subtitle: Text('Duración: 18:21 minutos'),
              onTap: () => launch('https://youtu.be/UkQ6-E4lbkk'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '4.- Experiencias, herramientas y desafíos de la ESI para el abordaje de abusos sexuales y embarazos forzados en niñas y adolescentes menores de 15 años'),
              subtitle: Text('Duración: 14 minutos'),
              onTap: () => launch('https://youtu.be/drDA6HUjQm8'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '5.- La importancia del abordaje integral y el acceso a la justicia en casos de abusos sexuales y embarazos forzados'),
              subtitle: Text('Duración: 15 minutos'),
              onTap: () => launch('https://youtu.be/PHZSBtYxbCg'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '6.- Abusos sexuales y embarazos forzados. Caracterización y orientaciones para un abordaje con enfoque de género y generacional (Partes 1)'),
              subtitle: Text('Duración: 15 minutos'),
              onTap: () => launch('https://youtu.be/G0uYvimqxAE'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '6.- Abusos sexuales y embarazos forzados. Caracterización y orientaciones para un abordaje con enfoque de género y generacional (Partes 2)'),
              subtitle: Text('Duración: 15 minutos'),
              onTap: () => launch('https://youtu.be/l5rBQMpsiHs'),
            ),
            ListTile(
              title: Text(
                'Webinarios realizados en el marco del curso "Anticoncepción en las adolescencias" - 2020',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(''),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '1.- Webinario: Protocolo para la atención integral de personas con derecho a la ILE, con énfasis en la asistencia a NNyA'),
              subtitle: Text('Duración: 1:01 horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=ZJfqGXmp7to'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '2.- Webinario: Respuestas y desafíos de las políticas frente al abuso sexual y embarazo forzado'),
              subtitle: Text('Duración: 1:45 horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=yVUopxQEa0M'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '3.- Webinario: Anticoncepción y modelo social de la discapacidad'),
              subtitle: Text('Duración: 1:31 horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=quQ1KhriWwM'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '4.- Webinario: Fortalecimiento de la perspectiva de diversidad sexual y corporal en el modelo de atención en salud'),
              subtitle: Text('Duración: 1:24 Horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=1eofLLleDbE'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title:
                  Text('5.- Webinario: Adolescencias, vínculos y violencias'),
              subtitle: Text('Duración: 1:24 Horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=IKIvGorudbw'),
            ),
            ListTile(
              title: Text(
                'Encuentros de actualización profesional sobre Interrupción Legal del Embarazo - 2020',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                  'Nota aclaratoria: Al momento de producción de estos videos no se encontraba sancionada la ley 27.610 que regula el acceso a la Interrupción Voluntaria y Legal del Embarazo y la atención post aborto de las adolescentes, mujeres y personas con capacidad de gestar. A partir de esta ley se reconoce el derecho a la interrupción voluntaria del embarazo (IVE) hasta la semana 14 inclusive y se mantiene el derecho a la interrupción legal del embarazo (ILE) por las causales: peligro para la vida o la salud de la persona gestante y/o violación.'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Causal salud, de la teoría la práctica Claves para su implementación'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=yOck9YXBF6Y'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Ruta crítica para las niñas y adolescentes embarazadas menores de 15 años'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=LQobVCJkXjw'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text('Aborto en 13 semanas y más'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=i44iOhXglUk'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Implementación y manejo de la Aspiración Manual Endouterina AMEU'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=RPKLMu72yIw'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Uso y manejo de misoprostol para el aborto con medicamentos hasta las 12 semanas'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=jcvXbbP1wDw'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Atención integral en la interrupción legal del embarazo'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=3Ljz6QB4G8M'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  'Protocolo para la atención integral de las personas con derecho a la interrupción legal del embarazo'),
              subtitle: Text('Duración: 10 minutos'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=LZEf3QtU1wI'),
            ),
          ],
        ),
      ),
    );
  }
}
