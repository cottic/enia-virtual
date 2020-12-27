import 'dart:math';
import 'dart:io';

import 'package:fluffychat/components/dialogs/simple_dialogs.dart';
import 'package:fluffychat/components/matrix.dart';
import 'package:fluffychat/config/app_config.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:fluffychat/utils/app_route.dart';
// import 'package:fluffychat/utils/sentry_controller.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'login.dart';
import 'package:flutter/foundation.dart';

class HomeserverPicker extends StatelessWidget {
  //Not need, because user cannot select a server
  /*     Future<void> _setHomeserverAction(BuildContext context) async {
    final homeserver = await SimpleDialogs(context).enterText(
        titleText: L10n.of(context).enterYourHomeserver,
        hintText: AppConfig.defaultHomeserver,
        prefixText: 'https://',
        keyboardType: TextInputType.url);
    if (homeserver?.isEmpty ?? true) return;
    _checkHomeserverAction(homeserver, context);
  }
*/

  void _checkHomeserverAction(String homeserver, BuildContext context) async {
    /* if (await SentryController.getSentryStatus() == null || true) {
      await SentryController.toggleSentryAction(context);
    } */

    if (!homeserver.startsWith('https://')) {
      homeserver = 'https://$homeserver';
    }

    final success = await SimpleDialogs(context).tryRequestWithLoadingDialog(
        Matrix.of(context).client.checkServer(homeserver));
    if (success != false) {
      await Navigator.of(context).push(AppRoute(Login()));
    }
  }

  final String platform = kIsWeb ? 'Web' : Platform.operatingSystem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
                  max((MediaQuery.of(context).size.width - 600) / 2, 0)),
          child: Column(
            children: <Widget>[
              Spacer(flex: 1),

              Hero(
                tag: 'loginBanner',
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Image.asset('assets/logo_enia_1025.png'),
                  ),
                ),
              ),

              Spacer(flex: 2),
              Hero(
                tag: 'loginButton',
                child: Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: RaisedButton(
                    elevation: 7,
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      L10n.of(context).connect.toUpperCase(),
                      style:
                          TextStyle(color: Theme.of(context).backgroundColor),
                    ),
                    onPressed: () => _checkHomeserverAction(
                        AppConfig.defaultHomeserver, context),
                  ),
                ),
              ),
              //Not need, because user cannot select a server

              /* Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: Text(
                  L10n.of(context).byDefaultYouWillBeConnectedTo(
                      AppConfig.defaultHomeserver),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ), */
              /* FlatButton(
                child: Text(
                  L10n.of(context).changeTheHomeserver,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                onPressed: () => _setHomeserverAction(context),
              ), */

              SizedBox(
                //TODO: en la version web mobile, el espacio no deberia existir, solo en web desktop
                height: kIsWeb ? 100 : 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
