import 'package:flutter/material.dart';

class DashboardMenuItem extends StatelessWidget {
  const DashboardMenuItem({@required this.title, this.subTitle, this.onTap});

  final String title;
  final String subTitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal:10, vertical: 5),
      child: ListTile(
        leading: Icon(
          Icons.bar_chart,
          color: Theme.of(context).primaryColor,
          size: 36,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subTitle,
          style: Theme.of(context).textTheme.caption,
        ),
        onTap: onTap,
      ),
    );
  }
}
