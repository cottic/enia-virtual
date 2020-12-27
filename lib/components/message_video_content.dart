import 'package:famedlysdk/famedlysdk.dart';
import 'package:flutter/material.dart';
import 'package:fluffychat/utils/event_extension.dart';

class MessageVideoContent extends StatelessWidget {
  final Event event;
  final Color textColor;

  const MessageVideoContent(this.event, this.textColor, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String filename = event.content.containsKey('filename')
        ? event.content['filename']
        : event.body;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          
          RaisedButton(
            color: textColor,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                SizedBox(height: 4),
                Icon(
                  Icons.ondemand_video,
                  size: 70,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  filename,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  maxLines: 1,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: 8),
              ],
            ),
            onPressed: () => event.openFile(context),
          ),
          if (event.sizeString != null)
            Text(
              event.sizeString,
              style: TextStyle(
                color: textColor,
              ),
            ),
        ],
      ),
    );
  }
}
