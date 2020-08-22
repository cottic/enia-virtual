import 'dart:io';

import 'package:famedlysdk/famedlysdk.dart';
import 'package:fluffychat/views/homeserver_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bot_toast/bot_toast.dart';

import 'l10n/l10n.dart';
import 'components/theme_switcher.dart';
import 'components/matrix.dart';
import 'views/chat_list.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(App());
}

class App extends StatelessWidget {
  final String platform = kIsWeb ? 'Web' : Platform.operatingSystem;
  @override
  Widget build(BuildContext context) {
    return Matrix(
      clientName: 'FluffyChat $platform',
      child: Builder(
        builder: (BuildContext context) => ThemeSwitcherWidget(
          child: Builder(
            builder: (BuildContext context) => MaterialApp(
              title: 'FluffyChat',
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              theme: ThemeSwitcherWidget.of(context).themeData,
              localizationsDelegates: [
                AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('es'), // Spanish
                // Only spanish is available in ENIA VIRTUAL
                /*
                const Locale('en'), // English
                const Locale('de'), // German
                const Locale('hu'), // Hungarian
                const Locale('pl'), // Polish
                const Locale('fr'), // French
                const Locale('cs'), // Czech
                const Locale('sk'), // Slovakian
                const Locale('gl'), // Galician
                const Locale('hr'), // Croatian
                const Locale('ja'), // Japanese
                const Locale('ru'), // Russian
                const Locale('uk'), // Ukrainian 
                */
              ],
              locale: kIsWeb
                  ? Locale(html.window.navigator.language.split('-').first)
                  : null,
              home: FutureBuilder<LoginState>(
                future:
                    Matrix.of(context).client.onLoginStateChanged.stream.first,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Scaffold(
                      backgroundColor: Theme.of(context).primaryColor,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: double.maxFinite,
                            child: Hero(
                              tag: 'loginBanner',
                              child: Image.asset('assets/logo_enia_1025.png'),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.16,
                          ),
                          //TODO: No funciona traduccion, fixear.
                          Text(
                            'Iniciando',
                            //L10n.of(context).initializing,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white)),
                        ],
                      ),
                    );
                  }
                  if (Matrix.of(context).client.isLogged()) {
                    return ChatListView();
                  }
                  return HomeserverPicker();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
