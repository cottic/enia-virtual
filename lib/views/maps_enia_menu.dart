import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chat_list.dart';
import '../components/adaptive_page_layout.dart';
import '../components/dialogs/simple_dialogs.dart';
import '../components/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class MapsEniaMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.SECOND,
      firstScaffold: ChatList(),
      secondScaffold: MapsEniaMenu(),
    );
  }
}

class MapsEniaMenu extends StatefulWidget {
  @override
  _MapsEniaMenuState createState() => _MapsEniaMenuState();
}

class _MapsEniaMenuState extends State<MapsEniaMenu> {
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
                'COLECCIÓN DE MAPAS',
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
                'Dispositivo para el fortalecimiento de la oferta en Salud Sexual y Reproductiva',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Cobertura de población, meta de colocación de DIU e implantes en departamentos y provincias ENIA'),
              subtitle: Text(
                  'Actualización: Trimestral. Fuente: INDEC - Equipo Monitoreo ENIA'),
              onTap: () => launch(
                  'https://google.com/maps/d/u/2/edit?mid=17D_NffBP-k32zyu0w3EjSYGfPtv-W-VF&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Nacidos vivos (de niñas y adolescentes menores de 20 años). Total país y departamentos ENIA. Año 2018'),
              subtitle: Text(
                  'Actualización: Trimestral. Fuente: DEIS (Ministerio de Salud) - Equipo Monitoreo ENIA'),
              onTap: () => launch(
                  'https://google.com/maps/d/u/1/edit?mid=1L3vZDKegEGgFbvP9qjiQxwv4GqHvJOp0&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Servicios de salud públicos que entregan y/o colocan métodos anticonceptivos. Total país'),
              subtitle: Text(
                  'Actualización: Trimestral. Fuente: Equipo Monitoreo ENIA'),
              onTap: () => launch(
                  'https://google.com/maps/d/edit?mid=1WCPiiNCItZDG32R4A2das-sIvZXS-W6t&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Efectores de salud según tipo de servicio. Departamentos ENIA'),
              subtitle: Text('Actualización: Trimestral. Fuente: DNSSR'),
              onTap: () => launch(
                  'https://google.com/maps/d/u/2/edit?mid=1o6iUDUXldZwGRNjKeEN1fDsZZ4QQ2gl5&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Efectores de salud públicos que dispensaron LARCs a menores de 20 años. Departamentos ENIA'),
              subtitle: Text('Actualización: Trimestral. Fuente: DNSSR'),
              onTap: () => launch(
                  'https://google.com/maps/d/u/2/edit?mid=1bOHC-GNYgm7hMrwW8xDsngv8aOgSWD0D&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Dispensa de LARCs en departamentos ENIA. Total acumulado a abril 2020'),
              subtitle: Text(
                  'Actualización: Trimestral. Fuente: Equipo Monitoreo ENIA'),
              onTap: () => launch(
                  'https://google.com/maps/d/edit?mid=1JQpFr8IkPCGgH4NRxwfFKvNMbHjW1zQs&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Servicios de salud públicos con personal capacitado bajo Plan, según temática'),
              subtitle: Text(
                  'Actualización: Trimestral. Fuente: Equipo Monitoreo ENIA'),
              onTap: () => launch(
                  'https://google.com/maps/d/edit?mid=1yuoVS7n0Cw_DCDnbg1yBMGlvALU5J1eT&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Caracterización de los servicios de salud públicos. Entrenamiento, consultas mensuales, personal e infraestructura'),
              subtitle: Text(
                  'Actualización: Trimestral. Fuente: Equipo Monitoreo ENIA'),
              onTap: () => launch(
                  'https://google.com/maps/d/u/1/edit?mid=1z41QAfyZ4vzJCr0o3O2WnftwhC2s0h_w&usp=sharing'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Dispositivo para el fortalecimiento de la Educación Sexual integral (ESI)',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
