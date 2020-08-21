import 'dart:math';

import 'package:famedlysdk/famedlysdk.dart';
import 'package:fluffychat/components/matrix.dart';
import 'package:fluffychat/l10n/l10n.dart';
import 'package:fluffychat/utils/app_route.dart';
import 'package:fluffychat/views/auth_web_view.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:memoryfilepicker/memoryfilepicker.dart';

import 'chat_list.dart';

class SignUpPassword extends StatefulWidget {
  final MemoryFile avatar;
  final String username;
  final String displayname;
  const SignUpPassword(this.username, {this.avatar, this.displayname});
  @override
  _SignUpPasswordState createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  final TextEditingController passwordController = TextEditingController();
  String passwordError;
  bool loading = false;
  bool showPassword = true;

  void _signUpAction(BuildContext context, {Map<String, dynamic> auth}) async {
    var matrix = Matrix.of(context);
    if (passwordController.text.isEmpty) {
      setState(() => passwordError = L10n.of(context).pleaseEnterYourPassword);
    } else {
      setState(() => passwordError = null);
    }

    if (passwordController.text.isEmpty) {
      return;
    }

    try {
      setState(() => loading = true);
      var waitForLogin = matrix.client.onLoginStateChanged.stream.first;
      await matrix.client.register(
        username: widget.username,
        password: passwordController.text,
        initialDeviceDisplayName: matrix.widget.clientName,
        auth: auth,
      );
      await waitForLogin;
    } on MatrixException catch (exception) {
      if (exception.requireAdditionalAuthentication) {
        final stages = exception.authenticationFlows
            .firstWhere((a) => !a.stages.contains('m.login.email.identity'))
            .stages;

        final currentStage = exception.completedAuthenticationFlows == null
            ? stages.first
            : stages.firstWhere((stage) =>
                !exception.completedAuthenticationFlows.contains(stage) ??
                true);

        if (currentStage == 'm.login.dummy') {
          _signUpAction(context, auth: {
            'type': currentStage,
            'session': exception.session,
          });
        } else {
          await Navigator.of(context).push(
            AppRoute.defaultRoute(
              context,
              AuthWebView(
                currentStage,
                exception.session,
                () => _signUpAction(context, auth: {
                  'session': exception.session,
                }),
              ),
            ),
          );
          return;
        }
      } else {
        setState(() => passwordError = exception.errorMessage);
        return setState(() => loading = false);
      }
    } catch (exception) {
      debugPrint(exception);
      setState(() => passwordError = exception.toString());
      return setState(() => loading = false);
    }
    await matrix.client.onLoginStateChanged.stream
        .firstWhere((l) => l == LoginState.logged);
    try {
      await matrix.client
          .setDisplayname(matrix.client.userID, widget.displayname);
    } catch (exception) {
      BotToast.showText(text: L10n.of(context).couldNotSetDisplayname);
    }
    if (widget.avatar != null) {
      try {
        await matrix.client.setAvatar(
          MatrixFile(
            bytes: widget.avatar.bytes,
            name: widget.avatar.path,
          ),
        );
      } catch (exception) {
        BotToast.showText(text: L10n.of(context).couldNotSetAvatar);
      }
    }
    await Navigator.of(context).pushAndRemoveUntil(
        AppRoute.defaultRoute(context, ChatListView()), (r) => false);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: loading ? Container() : null,
        title: Text(
          L10n.of(context).chooseAStrongPassword,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: max((MediaQuery.of(context).size.width - 600) / 2, 0)),
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.lock, color: Theme.of(context).primaryColor),
            ),
            title: TextField(
              controller: passwordController,
              obscureText: !showPassword,
              autofocus: true,
              autocorrect: false,
              onSubmitted: (t) => _signUpAction(context),
              decoration: InputDecoration(
                  hintText: '****',
                  errorText: passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () =>
                        setState(() => showPassword = !showPassword),
                  ),
                  labelText: L10n.of(context).password),
            ),
          ),
          SizedBox(height: 20),
          Hero(
            tag: 'loginButton',
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: RaisedButton(
                elevation: 7,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: loading
                    ? CircularProgressIndicator()
                    : Text(
                        L10n.of(context).createAccountNow.toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                onPressed: loading ? null : () => _signUpAction(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
