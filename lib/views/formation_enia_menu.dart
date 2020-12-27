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
                'MATERIALES EDUCATIVOS',
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
                  'El Embarazo No Intencional en la Adolescencia - 	Contenidos de Educación Sexual Integral '),
              subtitle: Text('Propuestas para el aula - Nivel Secundario'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/el_embarazo_no_intencional_en_la_adolescencia.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Cuadernillo ESI para Educación Secundaria I'),
              subtitle: Text('Contenidos y propuestas para el aula'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/cuadernillo_esi_para_educacion_secundaria_i.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Cuadernillo ESI para Educación Secundaria II '),
              subtitle: Text('Contenidos y propuestas para el aula'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/cuadernillo_esi_para_educacion_secundaria_ii.pdf'),
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
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Consejerías en Salud Sexual y Salud Reproductiva '),
              subtitle: Text(
                  'Propuesta de Diseño, Organización e Implementación - Documento de trabajo'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/consejeriasensaludsexualyreproductiva.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Talleres en Salud Sexual y Salud Reproductiva '),
              subtitle: Text('Manual "Experiencias para armar"'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/experienciasparaarmar.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Videos '),
              subtitle: Text(
                  'Campaña prevención embarazo no intencional en la adolescencia'),
              onTap: () => launch(
                  'https://www.youtube.com/watch?v=Kb_FDhmV8Io&feature=youtu.be'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Asesorías en las escuelas',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Asesorías en Salud Integral '),
              subtitle: Text('Estrategias y acciones'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/plan_enia_-_asesorias_en_salud_integral_en_las_escuelas_secundarias.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title:
                  Text('Asesorías en Salud Integral para Escuela Secundaria '),
              subtitle: Text('Lineamientos para la implementación'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/plan_enia_-asesorias_en_salud_integral_para_escuela_secundaria-_lineamiento.pdf'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Derechos',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Guía sobre derechos de adolescentes para el acceso al sistema de salud '),
              subtitle: Text('Lineamientos y normativas'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/guia_sobre_derechos_de_adolescentes_para_el_acceso_al_sistema_de_salud.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Derechos personalísimos de niñas, niños y adolescentes '),
              subtitle: Text(
                  'Acceso autónomo a la atención en salud integral, sexual y reproductiva'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/derechos_personalisimos_de_ninas_ninos_y_adolescentes.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Protocolo para la atención integral de las personas con derecho a la interrupción legal del embarazo (Actualización 2019) '),
              subtitle: Text(
                  'Derechos de las personas y obligaciones del sistema de salud, abordaje del equipo de salud, procedimiento para realizar la interrupción del embarazo y anticoncepción post interrupción del embarazo.'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/protocolo_ile_2019-2a_edicion.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Métodos Anticonceptivos'),
              subtitle: Text('Guía práctica para profesionales de la salud'),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/metodos_anticonceptivos.pdf'),
            ),
          ],
        ),
      ),
    );
  }
}
