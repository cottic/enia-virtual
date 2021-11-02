import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppConfig {
  static const String applicationName = 'FluffyChat';
  static String defaultHomeserver = dotenv.env['HOMESERVER'];
  static const String privacyUrl = 'https://fluffychat.im/en/privacy.html';
  static const String sourceCodeUrl =
      'https://gitlab.com/ChristianPauly/fluffychat-flutter';
  static const String supportUrl =
      'https://gitlab.com/ChristianPauly/fluffychat-flutter/issues';
}
