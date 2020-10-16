import 'package:bot_toast/bot_toast.dart';
import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:matrix_link_text/link_text.dart';

class SimpleDialogs {
  final BuildContext context;

  const SimpleDialogs(this.context);

  Future<String> enterText(
      {String titleText,
      String confirmText,
      String cancelText,
      String hintText,
      String labelText,
      String prefixText,
      String suffixText,
      bool password = false,
      bool multiLine = false,
      TextInputType keyboardType}) async {
    var textEditingController = TextEditingController();
    final controller = textEditingController;
    String input;
    await showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(titleText ?? 'Please enter a text'),
        content: TextField(
          controller: controller,
          autofocus: true,
          autocorrect: false,
          onSubmitted: (s) {
            input = s;
            Navigator.of(c).pop();
          },
          minLines: multiLine ? 3 : 1,
          maxLines: multiLine ? 3 : 1,
          obscureText: password,
          textInputAction: multiLine ? TextInputAction.newline : null,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            prefixText: prefixText,
            suffixText: suffixText,
            prefixStyle: TextStyle(color: Theme.of(context).primaryColor),
            suffixStyle: TextStyle(color: Theme.of(context).primaryColor),
            border: OutlineInputBorder(),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
                cancelText?.toUpperCase() ??
                    L10n.of(context).close.toUpperCase(),
                style: TextStyle(color: Colors.blueGrey)),
            onPressed: () => Navigator.of(c).pop(),
          ),
          FlatButton(
            child: Text(
              confirmText?.toUpperCase() ??
                  L10n.of(context).confirm.toUpperCase(),
            ),
            onPressed: () {
              input = controller.text;
              Navigator.of(c).pop();
            },
          ),
        ],
      ),
    );
    return input;
  }

  Future<bool> askConfirmation({
    String titleText,
    String contentText,
    String confirmText,
    String cancelText,
    bool dangerous = false,
  }) async {
    var confirmed = false;
    await showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(titleText ?? L10n.of(context).areYouSure),
        content: contentText != null ? LinkText(text: contentText) : null,
        actions: <Widget>[
          FlatButton(
            child: Text(
                cancelText?.toUpperCase() ??
                    L10n.of(context).close.toUpperCase(),
                style: TextStyle(color: Colors.blueGrey)),
            onPressed: () => Navigator.of(c).pop(),
          ),
          FlatButton(
            child: Text(
              confirmText?.toUpperCase() ??
                  L10n.of(context).confirm.toUpperCase(),
              style: TextStyle(color: dangerous ? Colors.red : null),
            ),
            onPressed: () {
              confirmed = true;
              Navigator.of(c).pop();
            },
          ),
        ],
      ),
    );
    return confirmed;
  }

  Future<void> inform({
    String titleText,
    String contentText,
    String okText,
  }) async {
    await showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: titleText != null ? Text(titleText) : null,
        content: contentText != null ? Text(contentText) : null,
        actions: <Widget>[
          FlatButton(
            child: Text(
              okText ?? L10n.of(context).ok.toUpperCase(),
            ),
            onPressed: () {
              Navigator.of(c).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> tryRequestWithLoadingDialog(Future<dynamic> request,
      {Function(MatrixException) onAdditionalAuth}) async {
    var completed = false;
    final futureResult = tryRequestWithErrorToast(
      request,
      onAdditionalAuth: onAdditionalAuth,
    ).whenComplete(() => completed = true);
    await Future.delayed(Duration(seconds: 1));
    if (completed) return futureResult;
    return showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        futureResult.then(
          (result) => Navigator.of(context).pop<dynamic>(result),
        );
        return AlertDialog(
          title: Text(L10n.of(context).loadingPleaseWait),
          content: LinearProgressIndicator(),
        );
      },
    );
  }

  Future<dynamic> tryRequestWithErrorToast(Future<dynamic> request,
      {Function(MatrixException) onAdditionalAuth}) async {
    try {
      return await request;
    } on MatrixException catch (exception) {
      if (exception.requireAdditionalAuthentication &&
          onAdditionalAuth != null) {
        return await tryRequestWithErrorToast(onAdditionalAuth(exception));
      } else {
        BotToast.showText(text: exception.errorMessage);
      }
    } catch (exception) {
      BotToast.showText(text: exception.toString());
      return false;
    }
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text(L10n.of(context).loadingPleaseWait),
        content: LinearProgressIndicator(),
      ),
    );
  }
}
