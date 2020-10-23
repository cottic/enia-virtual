import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:famedlysdk/famedlysdk.dart';
import 'package:fluffychat/views/homeserver_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:sentry/sentry.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

import 'components/matrix.dart';
import 'components/theme_switcher.dart';
import 'utils/famedlysdk_store.dart';
import 'views/chat_list.dart';

final sentry = SentryClient(dsn: '8591d0d863b646feb4f3dda7e5dcab38');

void captureException(error, stackTrace) async {
  debugPrint(error.toString());
  debugPrint(stackTrace.toString());
  final storage = await getLocalStorage();
  if (storage.getItem('sentry') == true) {
    await sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runZonedGuarded(
    () => runApp(App()),
    captureException,
  );
}

class App extends StatelessWidget {
  final String platform = kIsWeb ? 'Web' : Platform.operatingSystem;
  @override
  Widget build(BuildContext context) {
    return Matrix(
      clientName: 'enia@Virtual $platform',
      child: Builder(
        builder: (BuildContext context) => ThemeSwitcherWidget(
          child: Builder(
            builder: (BuildContext context) => MaterialApp(
              title: 'enia@virtual',
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              theme: ThemeSwitcherWidget.of(context).themeData,
              localizationsDelegates: L10n.localizationsDelegates,
              supportedLocales: L10n.supportedLocales,
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
                          Text(
                            L10n.of(context).loading,
                            style: TextStyle(color: Colors.white),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(
                            Matrix.versionENIA,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
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
