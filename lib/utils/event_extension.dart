import 'package:famedlysdk/famedlysdk.dart';
import 'package:fluffychat/components/dialogs/simple_dialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'matrix_file_extension.dart';
import 'app_route.dart';
import '../views/image_view.dart';

extension LocalizedBody on Event {
  void openFile(BuildContext context, {bool downloadOnly = false}) async {
    if (!downloadOnly &&
        [MessageTypes.Image, MessageTypes.Sticker].contains(messageType)) {
      await Navigator.of(context).push(
        AppRoute(
          ImageView(this),
        ),
      );
      return;
    }
    final MatrixFile matrixFile =
        await SimpleDialogs(context).tryRequestWithLoadingDialog(
      downloadAndDecryptAttachment(),
    );
    matrixFile.open();
  }

  IconData get statusIcon {
    switch (status) {
      case -1:
        return Icons.error_outline;
      case 0:
        return Icons.timer;
      case 1:
        return Icons.done;
      case 2:
        return Icons.done_all;
      default:
        return Icons.done;
    }
  }

  bool get showThumbnail =>
      [MessageTypes.Image, MessageTypes.Sticker].contains(messageType) &&
      (kIsWeb ||
          (content['info'] is Map &&
              content['info']['size'] is int &&
              content['info']['size'] < room.client.database.maxFileSize) ||
          (hasThumbnail &&
              content['info']['thumbnail_info'] is Map &&
              content['info']['thumbnail_info']['size'] is int &&
              content['info']['thumbnail_info']['size'] <
                  room.client.database.maxFileSize) ||
          (content['url'] is String));

  String get sizeString {
    if (content['info'] is Map<String, dynamic> &&
        content['info'].containsKey('size')) {
      num size = content['info']['size'];
      if (size < 1000000) {
        size = size / 1000;
        size = (size * 10).round() / 10;
        return '${size.toString()} KB';
      } else if (size < 1000000000) {
        size = size / 1000000;
        size = (size * 10).round() / 10;
        return '${size.toString()} MB';
      } else {
        size = size / 1000000000;
        size = (size * 10).round() / 10;
        return '${size.toString()} GB';
      }
    } else {
      return null;
    }
  }
}
