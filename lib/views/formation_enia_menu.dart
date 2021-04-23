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
                'Capacitaciones en curso y en inscripción',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://docs.google.com/document/d/1xQyxputekLdix4cM6Fu4GDXHyEgOoIeS5bes7llhzQo/edit?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.description),
              title: Text(
                'Oferta de propuestas de capacitación',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1y-hX11hK0Pb5QmYvaE30yRv5oBs83cVr/view?usp=sharing'),
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
                'Ciclo de Encuentros para un abordaje intersectorial de niñas y adolescentes menores de 15 años con embarazos forzados',
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
              subtitle: Text(
                  'Presenta: Victoria Keller (equipo técnico, Dirección de Adolescencias y Juventudes) Exponen: Juan Carlos Escobar (Director de Adolescencias y Juventudes) y Analía Messina (Consultora de la Dirección Nacional de Salud Sexual y Reproductiva) Fecha: 30/09/2020 Duración: 21:16 minutos'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=kJiU4NUg8pE'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '2.- Experiencias de atención integral de niñas y adolescentes de menores de 15 años víctimas de abuso sexual y embarazo forzado, una mirada federal. Experiencias de Jujuy y Entre Ríos'),
              subtitle: Text(
                  'Presenta: Diva Moreno (Consultora Unicef Argentina) Exponen: Leonardo Dato (Fiscal de la Unidad de Violencia de Género y Abuso Sexual, Entre Ríos), Fabiola Schreiner (Subdirectora de la Dirección de Restitución de Derechos, Entre Ríos), Roxana Zabala (Referente del Programa Provincial de Salud Integral en Adolescencias, Jujuy) y Claudia Castro (Referente del Programa Provincial de Salud Sexual y Reproductiva, Jujuy) Fecha: 20/10/2020 Duración: 21:16 minutos'),
              onTap: () => launch('https://youtu.be/qL2xlvasHgE'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '3.- Experiencias de atención integral de niñas y adolescentes de menores de 15 años víctimas de abuso sexual y embarazo forzado, una mirada federal. Experiencias de Mendoza y Chubut'),
              subtitle: Text(
                  'Presenta: Constanza Díaz (referente de la Unidad Ejecutora Plan Enia para la Dirección de Adolescencias y Juventudes) Exponen: Silvina Mollo (Jefa del Programa Provincial de Prevención y Atención Integral del Maltrato a la Niñez y Adolescencia, Mendoza) y Verónica Vivanco (Referente del Programa Provincial de Salud Sexual y Reproductiva y Referente del Departamento de Adolescencia, Chubut) Fecha: 27/10/2020 Duración: 18:21 minutos'),
              onTap: () => launch('https://youtu.be/UkQ6-E4lbkk'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '4.- Experiencias, herramientas y desafíos de la ESI para el abordaje de abusos sexuales y embarazos forzados en niñas y adolescentes menores de 15 años'),
              subtitle: Text(
                  'Presenta: Marina Montes (ESI, Ministerio de Educación de la Nación) Exponen: Paula Faisond (Dra en Educación, CABA) y Mara Gómez (Capacitadora de Centros de Formación Docente, Chubut) Fecha: 12/11/2020 Duración: 14 minutos'),
              onTap: () => launch('https://youtu.be/drDA6HUjQm8'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '5.- La importancia del abordaje integral y el acceso a la justicia en casos de abusos sexuales y embarazos forzados'),
              subtitle: Text(
                  'Presenta: Sabrina Viola (Unicef) Exponen: Mariana Melgarejo (Dirección del Sistema de Protección – Senaf), Josefina Sannen Mazzucco (Coordinadora del Cuerpo de Abogados para Víctimas de Violencia de Género) Fecha: 2/12/2020 Duración: 15 minutos'),
              onTap: () => launch('https://youtu.be/PHZSBtYxbCg'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '6.- Abusos sexuales y embarazos forzados. Caracterización y orientaciones para un abordaje con enfoque de género y generacional (Partes 1)'),
              subtitle: Text(
                  'Presenta: Luciana Lirman (Oficial Unicef) Exponen: Parte 1: Silvina Ramos (Coordinadora Área Técnica Plan Enia) y Nélida Sessini (Especialista en Maltrato y Abuso Sexual Infantil, Ministerio de Desarrollo Social y Hábitat, CABA) Fecha: 15/12/2020 Duración: 15 minutos'),
              onTap: () => launch('https://youtu.be/G0uYvimqxAE'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '6.- Abusos sexuales y embarazos forzados. Caracterización y orientaciones para un abordaje con enfoque de género y generacional (Partes 2)'),
              subtitle: Text(
                  'Parte 2: Celeste Leonardi (Abogada de la Dirección Nacional de Salud Sexual y Reproductiva)  y Sonia Ariza Navarrete (investigadora externa de CEDES) Fecha: 15/12/2020 Duración: 15 minutos'),
              onTap: () => launch('https://youtu.be/l5rBQMpsiHs'),
            ),
            ListTile(
              title: Text(
                'Webinarios del curso “Anticoncepción en las adolescencias',
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
              subtitle: Text(
                  'Presenta: Alejandra Sánchez Cabeza Exponen: Analía Messina (Consultora de la Dirección Nacional de Salud Sexual y Reproductiva) Fecha: 08/07/2020 Duración: 1:01 horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=ZJfqGXmp7to'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '2.- Webinario: Respuestas y desafíos de las políticas frente al abuso sexual y embarazo forzado'),
              subtitle: Text(
                  'Presenta: Alejandra Sánchez Cabeza Exponen: Tamar Finzi (socióloga, asesora del área técnica del Plan Enia), Celeste Leonardi (abogada, Coordinadora Institucional el Cuerpo de Abogadas/os para Víctimas de Violencia de Género del Ministerio de Justicia y Derechos Humanos de la Nación y asesora DNSSyR) y Sonia Ariza (abogada, investigadora externa del CEDES). Fecha: 13/08/2020 Duración: 1:45 horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=yVUopxQEa0M'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '3.- Webinario: Anticoncepción y modelo social de la discapacidad'),
              subtitle: Text(
                  'Presenta: Alejandra Sánchez Cabeza Exponen: Carolina Viviana Buceta (psicóloga, Integrante de la Red por los derechos de las personas con discapacidad) y Constanza Leone (coordinadora del Grupo de trabajo de derechos sexuales y reproductivos  y personas con discapacidad de la DNSSyR) Fecha: 17/09/2020 Duración: 1:31 horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=quQ1KhriWwM'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '4.- Webinario: Fortalecimiento de la perspectiva de diversidad sexual y corporal en el modelo de atención en salud'),
              subtitle: Text(
                  'Exponen: Alicia Comas (Antropóloga) y Diego García (médico), ambos integrantes de la Dirección de Géneros y Diversidad, MSAL Fecha: 14/10/2020 Duración: 1:24 Horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=1eofLLleDbE'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title:
                  Text('5.- Webinario: Adolescencias, vínculos y violencias'),
              subtitle: Text(
                  'Exponen: Juan Carlos Escobar (Médico pediatra y de adolescentes, Director de DIAJU-MSAL), Mariana Palumbo (Socióloga y Doctora en Ciencias Sociales por la Universidad de Buenos Aires. Trabaja temas de sexualidades, géneros y afectividades) y Lucas Grimson (estudiante de Ciencias Políticas, UBA) y Mariano Romano (profesor de Historia), ambos militantes de ·Desarmarnos - Masculinidades en Cuestión”. Fecha: 12/11/2020 Duración: 1:24 Horas'),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=IKIvGorudbw'),
            ),
            ListTile(
              title: Text(
                'Encuentros de actualización profesional sobre Interrupción Legal del Embarazo',
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
                  '1.- Protocolo para la atención integral de las personas con derecho a la interrupción legal del embarazo'),
              subtitle: Text(
                  'Docente: Analía Messina, médica tocoginecóloga, asesora de la DNSSyR Fecha: Agosto-Septiembre 2020 Duración: 10 minutos Modadalidad: Exposición dialogada con power point de apoyo '),
              onTap: () => launch(
                  'https://www.youtube.com/watch?v=LZEf3QtU1wI&feature=youtu.be'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '2.- Atención integral en la interrupción legal del embarazo'),
              subtitle: Text(
                  'Docente: Analía Messina, médica tocoginecóloga, asesora de la DNSSyR Fecha: Agosto-Septiembre 2020 Duración: 10 minutos Modadalidad: Exposición dialogada con power point de apoyo '),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=3Ljz6QB4G8M'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '3.- Uso y manejo de misoprostol para el aborto con medicamentos hasta las 12 semanas'),
              subtitle: Text(
                  'Docente: Analía Messina, médica tocoginecóloga, asesora de la DNSSyR Fecha: Agosto-Septiembre 2020 Duración: 10 minutos Modadalidad: Exposición dialogada con power point de apoyo '),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=jcvXbbP1wDw'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '4.- Implementación y manejo de la Aspiración Manual Endouterina AMEU'),
              subtitle: Text(
                  'Docente: Analía Messina, médica tocoginecóloga, asesora de la DNSSyR Fecha: Agosto-Septiembre 2020 Duración: 10 minutos Modadalidad: Exposición dialogada con power point de apoyo '),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=RPKLMu72yIw'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text('5.- Aborto en 13 semanas y más'),
              subtitle: Text(
                  'Docente: Analía Messina, médica tocoginecóloga, asesora de la DNSSyR Fecha: Agosto-Septiembre 2020 Duración: 10 minutos Modadalidad: Exposición dialogada con power point de apoyo '),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=i44iOhXglUk'),
            ),
            ListTile(
              trailing: Icon(Icons.ondemand_video),
              title: Text(
                  '7.- Causal salud, de la teoría la práctica Claves para su implementación'),
              subtitle: Text(
                  'Docente: Analía Messina, médica tocoginecóloga, asesora de la DNSSyR Fecha: Agosto-Septiembre 2020 Duración: 10 minutos Modadalidad: Exposición dialogada con power point de apoyo '),
              onTap: () =>
                  launch('https://www.youtube.com/watch?v=yOck9YXBF6Y'),
            ),
          ],
        ),
      ),
    );
  }
}
