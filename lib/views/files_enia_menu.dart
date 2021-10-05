import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'chat_list.dart';
import '../components/adaptive_page_layout.dart';
import '../components/content_banner.dart';
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
              background: ContentBanner(
                Uri.https('proyecto.codigoi.com.ar',
                    'appenia/enia-assets/images/trama-mds-lila.png'),

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
                'Lineamientos e información para una gestión basada en evidencia. Documentos sobre diseño, implementación, monitoreo y evaluación del Plan.',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Protocolos y guías',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Protocolo para la atención integral de las personas con derecho a la interrupción voluntaria y legal del embarazo. Actualización 2021. Resolución Ministerio de Salud 1535/2021.'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/protocolo-para-la-atencion-integral-de-las-personas-con-derecho-la-interrupcion-voluntaria'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Protocolo para la atención integral de personas víctimas de violaciones sexuales, Actualización 2021'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/protocolo-para-la-atencion-integral-de-personas-victimas-de-violaciones-sexuales'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Atención de niñas y adolescentes menores de 15 años embarazadas. Hoja de ruta: herramientas para orientar el trabajo de los equipos de salud. 2020. Resolución Ministerio de Salud 1841/2020.'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/atencion-de-ninas-y-adolescentes-menores-de-15-anos-embarazadas-hoja-de-ruta'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Anexo. Atención de NNA menores de 15 años embarazadas. Hoja de ruta'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/atencion-de-ninas-y-adolescentes-menores-de-15-anos-embarazadas-hoja-de-ruta-anexo'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Documentos técnicos y de apoyo a la gestión integral',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Impacto de la pandemia COVID-19 y respuestas adaptativas de los servicios de salud para garantizar los derechos de salud sexual y reproductiva'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/impacto-de-la-pandemia-covid-19-y-respuestas-adaptativas-de-los-servicios-de-salud-para'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Consejería en derechos a niñas y adolescentes víctimas de abuso sexual y embarazo forzado. Reflexiones sobre sus especificidades. Dimensiones claves para su abordaje.'),
              subtitle: Text('Enero 2021.'),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/consejeria-en-derechos-ninas-y-adolescentes-victimas-de-abuso-sexual-y-embarazo-forzado'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Embarazos no intencionales en niñas y adolescentes en las escuelas. Propuesta de su abordaje desde la ESI, 2021'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/documento_tecnico-n8.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Presentación Plan Enia 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/presentacion-abreviada-plan-nacional-de-prevencion-del-embarazo-no-intencional-en-la'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Proceso de instalación del dispositivo de Asesorías en Salud Integral en Escuelas Secundarias (ASIE), 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/apoyo-gestion-doc-n2-21-12.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Abusos sexuales y embarazo forzado en la niñez y adolescencia. Lineamientos para su abordaje interinstitucional.'),
              subtitle: Text('Actualización 2021.'),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/abusos-sexuales-y-embarazo-forzado-en-la-ninez-y-adolescencia-lineamientos-para-su-abordaje'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Anexo. Hoja de ruta ante situaciones de abuso sexual hacia niñas, niños y adolescentes. Sistema Educativo, 2021'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1s2uYcgcX4LeF60q-6nOQHvFaYyuX-L9t/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Anexo. Hoja de ruta ante situaciones de abuso sexual hacia niñas, niños y adolescentes. Sistema de salud, 2021'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1qcZaL4NgbEfP_6Ch07OapYF41ZAUerCs/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Anexo. Hoja de ruta ante situaciones de abuso sexual hacia niñas, niños y adolescentes. Organismos de protección de derechos de NNA, 2021'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1hGJsb0kimOIsgSEKwt3YF8pHiNGdz3tG/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia y la perspectiva de Discapacidad, 2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/el_plan_enia_y_la_perspectiva_de_la_discapacidad._documento_tecnico_no_3_-_marzo_2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Las obstétricas en la salud sexual y reproductiva. Una agente estratégico. Disponibilidad, competencias y marco regulatorio, 2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/las_obstetricas_en_la_salud_sexual_y_reproductiva._un_agente_estrategico._documento_tecnico_no_4_-_marzo_2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'El embarazo y la maternidad en la adolescencia en la argentina. Datos y hallazgos para orientar líneas de acción, 2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/el_embarazo_y_la_maternidad_en_la_adolescencia_en_la_argentina._documento_tecnico_no_5_-_mayo_2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Acceso a la justicia: abusos sexuales y embarazos forzados en niñas y adolescentes menores de 15 años, 2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/acceso_a_la_justicia._abusos_sexuales_y_embarazos_forzados_en_menores_de_15._documento_tecnico_ndeg_6_-_noviembre_2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia, Recorrido, logros y desafíos, 2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/plan-enia-recorrido-logros-y-desafios'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Documento base Plan Enia 2017-2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/documento-plan-nacional-de-prevencion-del-embarazo-no-intencional-en-la-adolescencia-2017'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Modalidad de intervención y dispositivos Plan Enia, 2018'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/implementacion_del_plan_nacional_enia_documento_tecnico_ndeg2_-_julio_2018_-_modalidad_de_intervencion_y_dispositivos.pdf'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Notas técnicas e informativas de salud sexual y reproductiva',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Ley 27610 IVE ILE Estándares legales. Nota técnica, 2021'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/nota-tecnica-3-ley-27610-estandares-legales-para-la-atencion-de-la-interrupcion-del'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Ley 27610 IVE ILE Aspectos médicos. Nota técnica, 2021.'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/note-tecnica-4-ley-27610-atencion-integral-de-las-personas-con-derecho-la-interrupcion'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Interrupción del embarazo con medicamentos, 2021'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/folleto-interrupcion-del-embarazo-con-medicamentos'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Aspiración Manual Endouterina. AMEU.'),
              subtitle: Text('Nota técnica 2021.'),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/nota-tecnica-2-aspiracion-manual-endouterina-ameu'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Anticoncepción Hormonal de Emergencia, AHE. Nota técnica, 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/nota-tecnica-1-anticoncepcion-hormonal-de-emergencia'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Recomendaciones para garantizar el acceso a las prestaciones en salud sexual y reproductiva en el contexto de pandemia de covid-19. Nota informativa, 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/nota-informativa-1-recomendaciones-para-garantizar-el-acceso-las-prestaciones-en-salud-0'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Métodos anticonceptivos: acceso y recambio en el contexto de pandemia. Nota informativa, 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/nota-informativa-2-metodos-anticonceptivos-acceso-y-recambio-en-el-contexto-de-pandemia'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Métodos anticonceptivos: acceso y recambio en el contexto de pandemia. Novedades sobre el DIU con levonorgestrel. Nota informativa 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/nota-informativa-3-metodos-anticonceptivos-acceso-y-recambio-en-el-contexto-de-pandemia'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Atención a niñas y adolescentes menores de 15 años. Nota informativa 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/nota-informativa-4-atencion-ninas-y-adolescentes-menores-de-15-anos'),
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
              title: Text('Implementar IVE-ILE'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1H85OuSrudrTFAPBu9yihq8f_CKwBqQyG/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Informe de gestión 2020  – Dirección Nacional de Salud Sexual y Reproductiva'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1FLp4sREG01lPZkGYP1o0eVrnKh8Sjz7v/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Documento sobre monitoreo del Plan Enia, 2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/sistema_de_monitoreo_plan_enia._documento_tecnico_no_7_-_noviembre_2019.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Fondo de Población de Naciones Unidas, UNFPA. Consecuencias socioeconómicas del embarazo en la adolescencia en Argentina, 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://www.argentina.gob.ar/sites/default/files/estudios_tecnicos_-_consecuencias_socioeconomicas_del_embarazo_en_la_adolescencia_en_argentina.pdf'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Línea Salud Sexual 0800. '),
              subtitle: Text('Reporte marzo-abril 2021'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/12D9X7ux6-qsh8LICUGF-L10MPk-e_6It/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Línea de Salud Sexual 0800'),
              subtitle: Text('Reporte Enero - Febrero 2021'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1Dj_yzbDHfzbSXjAA4lqR9-QmjHisPjnZ/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Línea de Salud Sexual 0800'),
              subtitle: Text('Reporte Noviembre - Diciembre 2020'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1D6nA1Hq6qN3MVUNTeVCoF78rOji9ZCNg/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Línea de Salud Sexual 0800'),
              subtitle: Text('Reporte Septiembre - Octubre 2020'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/13aB0JiVCWQUmb5DAkplW2Aka9Jv1xE2U/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Línea de Salud Sexual 0800'),
              subtitle: Text('Julio - Agosto 2020'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1E0llY5GxpSw8dhNSqdzlZtPsuf0KAOQM/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Línea de Salud Sexual 0800'),
              subtitle: Text('Mayo - Junio 2020'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/11TplWfVNOhqOpFKuJaW0SXw_f0rQlrkd/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Línea de Salud Sexual 0800'),
              subtitle: Text('Abril - Mayo 2020'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1MSHSaL3YQADQzozfJgecmKKqftuYpzL3/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Línea de Salud Sexual 0800'),
              subtitle: Text('Marzo 2020'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1IB7XfbuHuuhIh5L1IWyhjn0nxq1MfKGu/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia. Informe trimestral de monitoreo'),
              subtitle: Text('Enero - Marzo 2021'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1xg44XvWQGINZPc4SPmDHiEE3SdVbx5_C/view'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia. Informe anual de monitoreo'),
              subtitle: Text('2020'),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/informe-anual-de-monitoreo-ano-2020'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia. Informe de monitoreo'),
              subtitle: Text('Septiembre - Octubre 2020'),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/informe-bimestral-de-monitoreo-septiembre-octubre-2020'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia. Informe de monitoreo'),
              subtitle: Text('Julio - Agosto 2020'),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/informe-bimestral-de-monitoreo-julio-agosto-2020'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia. Informe de monitoreo'),
              subtitle: Text('Mayo - Junio 2020'),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/informe-bimestral-de-monitoreo-mayo-junio-2020'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia. Informe de monitoreo'),
              subtitle: Text('Abril - Mayo 2020'),
              onTap: () => launch(
                  'https://bancos.salud.gob.ar/recurso/informe-bimestral-de-monitoreo-abril-mayo-2020'),
            ),
          ],
        ),
      ),
    );
  }
}
