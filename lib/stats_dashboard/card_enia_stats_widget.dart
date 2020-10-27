import 'package:flutter/material.dart';

class CardEniaStats extends StatelessWidget {
  CardEniaStats({this.title, this.subTitle, this.data, this.icon});

  final String title;
  final String subTitle;
  final String data;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0XFFF9F9F9),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: Text('Total de LARCS'),
          subtitle: Text('Total de LARCS.'),
          trailing:
              Icon(Icons.accessibility_new, size: 50, color: Colors.green),
          leading: Text(
            '8902',
            overflow: TextOverflow.visible,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
