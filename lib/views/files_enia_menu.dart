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
                  'Lineamientos e información para una gestión basada en evidencia. Documentos sobre diseño, implementación, monitoreo y evaluación del Plan.'),
            ),
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
                  'Embarazos no intencionales en niñas y adolescentes en las escuelas. Propuesta de su abordaje desde la ESI, 2021'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1aO-FIP1aE8Yk6axIkKc-2qgkv0B277zP/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Presentación Plan Enia 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1vxJDiv0spiMFunm0bEJqZeZ-rxbNdh35/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Proceso de instalación del dispositivo de Asesorías en Salud Integral en Escuelas Secundarias (ASIE), 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1LTVE8nKoe1kuBrbyFe_xFvlfVNCCikp2/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Abusos sexuales y embarazo forzado en la niñez y adolescencia. Lineamientos para su abordaje interinstitucional, 2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1P-V-t8OlaKqt0hjOasaRNlU1ZXL5iVbq/view?usp=sharing'),
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
                  'https://drive.google.com/file/d/1lT5LTrluHA9Lq-zdiavD_9xzCGcF78-k/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Las obstétricas en la salud sexual y reproductiva. Una agente estratégico. Disponibilidad, competencias y marco regulatorio, 2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/194s6o4Qgm9A6y_4w6Irti0BESNqJnMHv/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'El embarazo y la maternidad en la adolescencia en la argentina. Datos y hallazgos para orientar líneas de acción, 2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1DXchNajP9cxsA-uan2JWxdbMnr59q69Y/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Acceso a la justicia: abusos sexuales y embarazos forzados en niñas y adolescentes menores de 15 años, 2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1H-s5F0d9qQHIBfAo9UCYEKkz8rEfbfeZ/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia, Recorrido, logros y desafíos, 2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1Fe6O-ld1LHIGU9H2rbWpTrdWnGqKAV2k/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Documento base Plan Enia 2017-2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1yd5oz0XFx1TTODyBh37dGY-eeS_guPnJ/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Modalidad de intervención y dispositivos Plan Enia, 2018'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1pQ6NmMjTE43PfTYKepGMPrg3PUZ2FwUC/view?usp=sharing'),
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
                  'https://drive.google.com/file/d/17X9ypA5r5nsDzU43r6WKAZ6prUQumyh3/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Ley 27610 IVE ILE Aspectos médicos. Nota técnica, 2021.'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1Ov2qa8AfyHwcQZECaKY0qAmxWHEtAKcM/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Interrupción del embarazo con medicamentos, 2021'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1sHoW7-q9uAmBSNhljpVvG5YKOCf71FD5/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Aspiración Manual Endouterina, AMEU. Nota técnica, 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1WISl56ziOsV9BQVFLkHNFWpznq0GwXeN/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Anticoncepción Hormonal de Emergencia, AHE. Nota técnica, 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/19BU24cNyvElxl1himHEDoj6twxCLZem8/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Recomendaciones para garantizar el acceso a las prestaciones en salud sexual y reproductiva en el contexto de pandemia de covid-19. Nota informativa, 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1UpCheFCCWtVZNMEYiyE1K415w0HaYF1o/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Métodos anticonceptivos: acceso y recambio en el contexto de pandemia. Nota informativa, 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1nFIzA2lDOI5vCfu8xcYLuWhvwKEqK_PR/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Métodos anticonceptivos: acceso y recambio en el contexto de pandemia. Novedades sobre el DIU con levonorgestrel. Nota informativa 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1fn34EvLrj12rZIp7br3cNNmLzxhmSD8J/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Atención a niñas y adolescentes menores de 15 años. Nota informativa 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1aKNxZjxNGTiB4EAZ-PoRN1fch3pevp03/view?usp=sharing'),
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
              title: Text('Documento sobre monitoreo del Plan Enia, 2019'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1RiWnEDy7tK6cUs6az8pkrcsbNF_INZNs/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Fondo de Población de Naciones Unidas, UNFPA. Consecuencias socioeconómicas del embarazo en la adolescencia en Argentina, 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1xTtCsTgRLmgTTSkVtLNnhphOHG6umFl0/view?usp=sharing'),
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
              title: Text('Plan Enia. Informe anual de monitoreo'),
              subtitle: Text('2020'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1_OHa6FQOHbQ4Dg2Vwoc5CRh5TYqRHQp7/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia. Informe de monitoreo'),
              subtitle: Text('Septiembre - Octubre 2020'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1WTdOliDYLXwXmjss1VzPJH3zVNB1crgP/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia. Informe de monitoreo'),
              subtitle: Text('Julio - Agosto 2020'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1g1SkWPB0bBrr5PdAA6T6X-tReEh1Zm9A/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia. Informe de monitoreo'),
              subtitle: Text('Mayo - Junio 2020'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1XTc2AjEmUssWbwC52f4Jy-EPKnI4exIg/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia. Informe de monitoreo'),
              subtitle: Text('Abril - Mayo 2020'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1MSHSaL3YQADQzozfJgecmKKqftuYpzL3/view?usp=sharing'),
            ),
            Divider(thickness: 1),
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
                  'Resolución Ministerio de Salud 1841/2020. Atención de niñas y adolescentes menores de 15 años embarazadas. Hoja de ruta: herramientas para orientar el trabajo de los equipos de salud. 2020'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1vvOlxcDK21v-fbN2T-SGbm9ktJUu2L-A/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Anexo. Atención de NNA menores de 15 años embarazadas. Hoja de ruta'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/170XWpu8gkP0oVkdbUlO7ig7YWbiEM1cC/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Protocolo para la atención integral de personas víctimas de violencia sexual, 2021'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1kt74mzZtks2iSNjsmJxBqkETxAiQX0ma/view?usp=sharing'),
            ),
          ],
        ),
      ),
    );
  }
}
