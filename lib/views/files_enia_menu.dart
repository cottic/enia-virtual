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
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1wNtYVF0uVJYVxwlisXulrUxxCSyyyMbr/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Plan Nacional de Prevención del Embarazo no Intencional en la Adolescencia - 2017/2019 '),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1skcAX7znWw2EHorqoIyzWZ2hp-xySlQ3/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Implementación del Plan Nacional Enia'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1qlpHurfXXgRV69M3myjo_gxoUKyND8zM/view?usp=sharing'),
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
                  'Abusos sexuales y embarazo forzado hacia niñas, niños y adolescentes. Argentina, América Latina y el Caribe.'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1WatOcMaqQahCDzLztBSFWdH2p8ipOXla/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Abusos sexuales y embarazo forzado en la niñez y la adolescencia'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1nYvr1X9Zlg3sZjdR9lqYa3KIbLvSz4jh/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('El Plan ENIA y la perspectiva de la discapacidad'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1p9DidnuAvLhhDuA0ZoXiLjmsndqtwTnT/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Las obstétricas en la salud sexual y reproductiva. Un agente estratégico'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1tl89NuqG_cnxUPWOAdjpeRvvMpcWGASW/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'El embarazo y la maternidad en la adolescencia en la Argentina'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1Kaem7XDODLHRylBvMpbQntAqA4TcYTQN/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Acceso a la justicia: abusos sexuales y embarazos forzados en niñas y adolescentes menores de 15 años'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1esrd-4tgGX51FDBiV0kUDIlj10KdYMqX/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Sistema de Monitoreo Plan ENIA	'),
              subtitle: Text('Documento técnico Nº 7 - Noviembre 2019'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1PEZclfL1rWCzKRJCGrMP_Yr5S52VS2jF/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Embarazos no intencionales en niñas y adolescentes en las escuelas.'),
              subtitle: Text(
                  'Propuestas para sus abordajes desde la ESI. Documento técnico N°8'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1WatOcMaqQahCDzLztBSFWdH2p8ipOXla/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Consecuencias socioeconómicas del embarazo en la adolescencia en Argentina.'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1vQXE9UxtSzewZehAFCF09vdUyCr3mSG8/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Nota técnica AMEU'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1wOXpDtIcNH_YPdb0ydsfS7jCpwHnBEI_/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Nota técnica AHE'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1cmIP2Y_Rz4yMmYKLr2PF1Rzy2uF88SBG/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.folder),
              title: Text('Reportes bimestrales en base a secuencias 0800'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/drive/folders/1ZMNssAgPkNmTE75tUgtHGAyf7URTglet?usp=sharing'),
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
                  'Atención de niñas y adolescentes menores de 15 años embarazadas.'),
              subtitle: Text(
                  'Hoja de ruta. Herramientas para orientar el trabajo de los equipos de salud'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1QUxK50ruh1j2pDWOne-9vaudQZg3X3nn/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Atención de niñas y adolescentes menores de 15 años embarazadas. Hoja de ruta.'),
              subtitle: Text(
                  'Anexo: Embarazo de alto riesgo obstétrico y psicosocial'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1vCuho-E1wPj3bBrKyBQFG3LTbs1aFM2u/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text(
                  'Proceso de instalación del dispositivo de Asesorías en Salud Integral en Escuelas Secundarias (ASIE).'),
              subtitle: Text('Doc de apoyo a la gestión N°2'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1oznNBKnIHDmVNEBjC4VwxF-asqToV1g1/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Nota informativa 1'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1iMWaKF7q3U2mpCrF9SuEq-VimtImW4xA/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Nota informativa 2'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1Xnpopk4s8Xjn0TgO4YNghjxi4sBIjlEM/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Nota informativa 3'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1W6dbWkR73sXvgc-C-e0DrRW93ihyDxU0/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Nota informativa 4'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/file/d/11ee4zH8_HRPcM05lbWOPsRzjPmDy_Rbm/view?usp=sharing'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Documentos de Monitoreo y Evaluación',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.picture_as_pdf),
              title: Text('Plan Enia. Recorrido, logros y desafíos.'),
              subtitle: Text('Mayo 2020'),
              onTap: () => launch(
                  'https://drive.google.com/file/d/1bw1VtxZxiXgrpz1u-PtOGRUvAKF871BT/view?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.folder),
              title: Text('Informes de monitoreo.'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/drive/folders/1GpB53FLrHUN6JOYDtIJ2uvnfJz7YofPW?usp=sharing'),
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
              trailing: Icon(Icons.folder),
              title: Text('Periódicos Plan ENIA 2020.'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/drive/folders/1GCWMa9KNyWm4VljN5BZaeTEV_WPiPQ4l?usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.folder),
              title: Text('Periódicos Plan ENIA 2021.'),
              subtitle: Text(''),
              onTap: () => launch(
                  'https://drive.google.com/drive/folders/18gXy7HHhqXzMo2H3Cm3hEFUPmTVCuoW9?usp=sharing'),
            ),
          ],
        ),
      ),
    );
  }
}
