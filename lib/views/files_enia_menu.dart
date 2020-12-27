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
                  'En esta sección podés consultar documentos sobre el diseño, implementación y evaluación del Plan Enia que brindan lineamientos e información para una gestión basada en la evidencia. Encontrarás distintos materiales, desde los primeros documentos de diseño del plan, documentos técnicos con diferentes ejes temáticos, hasta informes de monitoreo, entre otros.'),
            ),
            ListTile(
              title: Text(
                'Documentos de diseño',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Plan Nacional de Prevención del Embarazo no Intencional en la Adolescencia - 2020'),
              subtitle: Text('Año 2020'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Presentacion-base-ENIA-27-09-2020.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Plan Nacional de Prevención del Embarazo no Intencional en la Adolescencia - 2017/2019'),
              subtitle: Text('Año 2017/2019'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/documento_oficial_plan_2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Implementación del Plan Nacional ENIA'),
              subtitle: Text('Documento técnico Nº 2 / Julio 2018'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/implementacion_del_plan_nacional_enia_documento_tecnico_ndeg2_-_julio_2018_-_modalidad_de_intervencion_y_dispositivos.pdf'),
            ),
            Divider(thickness: 1),
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
              title: Text(
                  'Catálogo de documentos Plan Nacional Prevención del Embarazo no Intencional en la Adolescencia'),
              subtitle: Text('Marzo 2020'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/catalogo_de_documentos_del_plan_enia_0.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Abusos sexuales y embarazo forzado hacia niñas, niños y adolescentes Argentina, América Latina y el Caribe'),
              subtitle: Text('Autoras: Silvia Chejter y Valeria Isla'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/abusos_sexuales_y_embarazo_forzado_hacia_ninas_ninos_y_adolescentes.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Abusos Sexuales y Embarazo forzado en la niñez y adolescencia.'),
              subtitle: Text(
                  'Lineamientos para su abordaje interinstitucional. Anexo'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/abusos_sexuales_y_embarazo_forzado._lineamientos._anexo.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('El Plan ENIA y la perspectiva de la discapacidad'),
              subtitle: Text('Documento técnico Nº 3 - Marzo 2019'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/el_plan_enia_y_la_perspectiva_de_la_discapacidad._documento_tecnico_no_3_-_marzo_2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Las obstétricas en la salud sexual y reproductiva. Un agente estratégico'),
              subtitle: Text('Documento técnico Nº 4 - Marzo 2019'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/las_obstetricas_en_la_salud_sexual_y_reproductiva._un_agente_estrategico._documento_tecnico_no_4_-_marzo_2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'El embarazo y la maternidad en la adolescencia en la Argentina'),
              subtitle: Text('Documento técnico Nº 5 - Mayo 2019'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/el_embarazo_y_la_maternidad_en_la_adolescencia_en_la_argentina._documento_tecnico_no_5_-_mayo_2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'A cceso a la justicia: abusos sexualesy embarazos forzados en niñasy adolescentes menores de 15 años'),
              subtitle: Text('Documento técnico Nº 6 - Noviembre 2019'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/acceso_a_la_justicia._abusos_sexuales_y_embarazos_forzados_en_menores_de_15._documento_tecnico_ndeg_6_-_noviembre_2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Sistema de Monitoreo Plan ENIA'),
              subtitle: Text('Documento técnico Nº 7 - Noviembre 2019'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/sistema_de_monitoreo_plan_enia._documento_tecnico_no_7_-_noviembre_2019.pdf'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Documentos de apoyo a la gestión',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Atención de niñas y adolescentes menores de 15 años embarazadas'),
              subtitle: Text(
                  'Hoja de ruta. Herramientas para orientar el trabajo de los equipos de salud.'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/atencion-embarazo-adolescente-21-9-2020_1.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Atención de niñas y adolescentes menores de 15 años embarazadas. Hoja de ruta.'),
              subtitle: Text(
                  'Anexo: Embarazo de alto riesgo obstétrico y psicosocial'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/anexo-hoja-ruta-atencion-embarazo-adolescente-21-9-2020.pdf'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Documentos de monitoreo y evaluación',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Informe Bimestral de Monitoreo'),
              subtitle: Text('Julio - Agosto 2020'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Plan-Enia-Informe-bimestral-monitoreo-_-julio-agosto-2020.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Informe Bimestral de Monitoreo'),
              subtitle: Text('Mayo - Junio 2020'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Plan-Enia-Informe-bimestral-monitoreo_mayo-junio-2020.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Informe Bimestral de Monitoreo'),
              subtitle: Text('Abril - Mayo 2020'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Plan-Enia-Informe-bimestral-abril-mayo-2020.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia. Recorrido, logros y desafíos'),
              subtitle: Text('Mayo 2020'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/plan_enia._recorrido_logros_y_desafios_mayo_2020.pdf'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Periódicos Plan ENIA',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico'),
              subtitle: Text('Diciembre 2020'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Periodico-Diciembre-2020.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico'),
              subtitle: Text('Julio 2020'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Periodico-Julio-2020.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico'),
              subtitle: Text('Abril 2020'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Periodico-abril-2020.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico'),
              subtitle: Text('Agosto 2019'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Periodico-Agosto-2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico'),
              subtitle: Text('Junio 2019'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Periodico-Junio-2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico'),
              subtitle: Text('Mayo 2019'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Periodico-mayo-2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico'),
              subtitle: Text('Marzo 2019'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Periodico-marzo-2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico'),
              subtitle: Text('Febrero 2019'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Periodico-Febrero-2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico'),
              subtitle: Text('Enero 2019'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Periodico-Enero-2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico'),
              subtitle: Text('Noviembre 2018'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Periodico-Noviembre-2018.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico'),
              subtitle: Text('Octubre 2018'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Periodico-Octubre-2018.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Periódico'),
              subtitle: Text('Septiembre 2018'),
              onTap: () => launch(
                  'http://enia.codigoi.com.ar/wp-content/uploads/2020/12/Periodico-Septiembre-2018.pdf'),
            ),
          ],
        ),
      ),
    );
  }
}
