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
                'Mapas de monitoreo',
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
                'Mapas para disponibilizar y sistematizar los recursos y acciones del Plan. Una oportunidad para obtener diversas lecturas posibles y una representación sencilla, precisa y actualizada de la información disponible. ',
              ),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'ABUSO SEXUAL Y EMBARAZO FORZADO EN NIÑAS Y ADOLESCENTES MENORES DE 15 AÑOS',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(thickness: 1),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text('Dimensión Diagnóstica'),
              subtitle: Text(
                  'Presenta indicadores de la problemática de abuso sexual y embarazo forzado. Los datos por cada tipo de indicadores se visualizan por jurisdicción y se analizan en función de la media nacional.'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=1OklHCaBYixCqCKUneN8SnqNJuUyVYcFY&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text('Dimensión Normativa'),
              subtitle: Text(
                  'Se encuentra toda la información normativa relacionada con ASI por provincias y por instituciones involucradas en su abordaje.'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=1bsuvcx9qF9mP0IVjcEgn84yYOz-mUmnZ&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text('Dimensión institucional'),
              subtitle: Text(
                  'Organismos del Estado georeferenciados con datos e información, involucrados en el abordaje de situaciones de abuso sexual y embarazo forzado de niñas y adolescentes.'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=1pzof-JzbQUF_Q0C5X-FoSZ7Hb6NskR12&usp=sharing'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'COLECCIÓN DE MAPAS DE MONITOREO',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(thickness: 1),
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
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text('Cantidad de casos de ILE por efector de salud'),
              subtitle: Text('Casos de ILE por efector de salud'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=1qEIXcKfxqNDnfq-AK33Sby7jlaoUAx69&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text('Embarazos no planificados en menores de 15 años'),
              subtitle: Text('Embarazos no planificados en menores de 15 años'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=178QBtwVPqB72rQNBtzWrJxNuI8wwcZne&usp=sharing'),
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
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Escuelas bajo Plan y cobertura de escuelas y acompañantes pedagógicos en departamentos y provincias ENIA'),
              subtitle: Text(
                  'Escuelas con acompañante pedagógico ESI asignado/a: Provincias ENIA'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/edit?mid=1j_aiEGTrUYoPohEIRRIJzWfcS8sOdLpo&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Escuelas bajo Plan y cobertura de escuelas y acompañantes pedagógicos en departamentos y provincias ENIA'),
              subtitle: Text(
                  'Escuelas con acompañante pedagógico ESI asignado/a: Gran Buenos Aires'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=1YPi6epqG1zVUKYMJ0C9Wmn-hViznAG48&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Caracterización del/la acompañante pedagógico/a, por escuela, departamentos ENIA'),
              subtitle: Text('Datos AP por escuela - Departamentos ENIA'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=1P10agW-xgdmSXjQ63v6ys66np9kt3kyH&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Matrícula de estudiantes y plantel docente, según ciclo, por departamento y por provincia'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=1F2vC5kydQzmWJnsBzB4jDRcw6KdSFD9r&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Cantidad de estudiantes que recibieron actividades ESI-ENIA según provincia y departamento. Acumulado a Octubre 2020. Total Jurisdicciones ENIA'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/edit?mid=1Cn8Fzx6hzBf8Sq7LreC1EJwcqWyxui8q&usp=sharing'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Dispositivo de asesorías en Salud Integral en la Adolescencia',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Asesorías DIAJU según localización, por departamento y provincia'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=16iQ9d45yBdIKLbLat4-nW0fFBXVkMzSd&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Escuelas y servicios de salud con Asesorías en Salud Integral en la adolescencia (actualizado a octubre 2020)'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=1ySWkQLpKipUZSu1tBlu2Xe4BmIlfTg-c&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Escuelas con/sin asesorías en salud integral en la adolescencia y caracterización asesor/a'),
              subtitle: Text('Escuelas con/sin asesor/a DIAJU'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=1Ur5z3Q207uk8Ri_KC7FFMWLVu6iIJE3J&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text('Porcentaje de alcance de adolescentes asesorades'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=1v80oG1Xb1hUb8rXPxk4RVsRF624mQPVN&usp=sharing'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                'Dispositivo de asesorías en Salud Integral en la Adolescencia de base comunitaria',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text(
                  'Cantidad de asesorías comunitarias y asesoramientos, por departamento y provincia'),
              subtitle: Text('Escuelas con/sin asesor/a DIAJU'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=1D9jo7KOQh9gjl5IMsk0VYSngA352zoEZ&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text('Espacios comunitarios DBC, según tipo'),
              subtitle: Text('Espacios comunitarios DBC - Provincias ENIA'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=1UjesJJNilyu6yu2HazXWiDtpFq5SeSKU&usp=sharing'),
            ),
            ListTile(
              trailing: Icon(Icons.map_outlined),
              title: Text('Espacios comunitarios DBC, según tipo'),
              subtitle: Text('Zoom en GBA: Espacios comunitarios DBC - GBA'),
              onTap: () => launch(
                  'https://www.google.com/maps/d/u/1/edit?mid=1Vwgj0JrFYXhKFA74SI70Xm0K9NTLZSv1&usp=sharing'),
            ),
          ],
        ),
      ),
    );
  }
}
