import 'package:famedlysdk/famedlysdk.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/utils/string_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'matrix.dart';

class Avatar extends StatelessWidget {
  final Uri mxContent;
  final String name;
  final double size;
  final Function onTap;
  static const double defaultSize = 44;

  const Avatar(
    this.mxContent,
    this.name, {
    this.size = defaultSize,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var thumbnail = mxContent?.getThumbnail(
      Matrix.of(context).client,
      width: size * MediaQuery.of(context).devicePixelRatio,
      height: size * MediaQuery.of(context).devicePixelRatio,
      method: ThumbnailMethod.scale,
    );
    final src = thumbnail;
    var fallbackLetters = '@';
    if ((name?.length ?? 0) >= 2) {
      fallbackLetters = name.substring(0, 2);
    } else if ((name?.length ?? 0) == 1) {
      fallbackLetters = name;
    }
    final noPic = mxContent == null || mxContent.toString().isEmpty;
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: size / 2,
        backgroundImage: !noPic
            ? PlatformInfos.isBetaDesktop
                ? NetworkImage(src)
                : CachedNetworkImageProvider(src)
            : null,
        backgroundColor: noPic
            ? name?.lightColor ?? Theme.of(context).secondaryHeaderColor
            : Theme.of(context).secondaryHeaderColor,
        child: noPic
            ? Text(fallbackLetters, style: TextStyle(color: Colors.white))
            : null,
      ),
    );
  }
}
