import 'package:flutter/material.dart';

class CardChartHolder extends StatelessWidget {
  const CardChartHolder(
      {this.title, this.description, this.icon, this.dataWidget});

  final String title;
  final String description;
  final IconData icon;
  final Widget dataWidget;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0XFFF9F9F9),
      child: Column(
        children: [
          ListTile(
            title: Text(title ?? ''),
            subtitle: Text(description ?? ''),
          ),
          Icon(icon, size: 50, color: Colors.green),
          dataWidget,
        ],
      ),
    );
  }
}
