import 'package:fluffychat/stats_dashboard/charts/card_chart_widget.dart';
import 'package:flutter/material.dart';

import 'enia_icons.dart';

class CardChartHolder extends StatelessWidget {
  const CardChartHolder(
      {this.title, this.description, this.icon, this.chartUrl, this.color});

  final String title;
  final String description;
  final String icon;
  final String chartUrl;
  final bool color;

  @override
  Widget build(BuildContext context) {
    var screenSize = false;
    if (MediaQuery.of(context).size.width <= 1160) {
      screenSize = true;
    } else {
      screenSize = false;
    }
    return Expanded(
      child: Card(
        elevation: 3.0,
        margin: EdgeInsets.all(10.0),
        color: Color(0XFFFAFAFA),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(getIcon(icon),
                  size: screenSize ? 40 : 60,
                  color: color
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).accentColor),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: CardEniaStats(
                      color: color
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).accentColor,
                      apiUrl: chartUrl,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      title ?? '',
                      overflow: TextOverflow.clip,
                      style:
                          TextStyle(color: Color(0XFFA6A6A6), fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

IconData getIcon(String iconSelected) {
  switch (iconSelected) {
    case 'embarazada':
      return Icons.pregnant_woman;
      break;
    case 'anticoncepcion':
      return Icons.block;
      break;
    case 'hombre':
      return Icons.accessibility;
      break;
    case 'trans':
      return Icons.title;
      break;
    case 'otros':
      return Icons.panorama_fish_eye;
      break;
    case 'edificio':
      return Icons.domain;
      break;
    case 'familia':
      return Icons.family_restroom;
      break;
    case 'madreHijo':
      return Icons.escalator_warning;
      break;
    case 'ayuda':
      return Icons.support_agent;
      break;
    case 'medico':
      return Icons.medical_services;
      break;
    case 'hospital':
      return Icons.local_hospital;
      break;
    case 'distribucion':
      return Icons.local_shipping;
      break;
    case 'telefono':
      return Icons.phone_iphone;
      break;
    case 'casa':
      return Icons.home;
      break;
    case 'evento':
      return Icons.event;
      break;
    case 'escuela':
      return Icons.school;
      break;
    case 'adolescente':
      return EniaIcons.adolescente;
      break;
    case 'ninios':
      return EniaIcons.ninios;
      break;
    case 'diu':
      return EniaIcons.diu;
      break;
    case 'implante':
      return EniaIcons.implante;
      break;
    case 'enia1':
      return EniaIcons.enia1;
      break;
    case 'enia2':
      return EniaIcons.enia2;
      break;
    case 'mujer':
      return EniaIcons.mujer;
      break;
    case 'mujermas':
      return EniaIcons.mujermas;
      break;
    case 'adolescente2':
      return EniaIcons.adolescente2;
      break;
    case 'escuela1':
      return EniaIcons.escuela1;
      break;
    case 'escuela2':
      return EniaIcons.escuela2;
      break;
    case 'escuelaap':
      return EniaIcons.escuelaap;
      break;
    case 'estudiantesbasico':
      return EniaIcons.estudiantesbasico;
      break;
    case 'estudiantesorientado':
      return EniaIcons.estudiantesorientado;
      break;
    case 'centrocomunitario':
      return EniaIcons.centrocomunitario;
      break;
    case 'docente':
      return EniaIcons.docente;
      break;
    case 'escuela10':
      return EniaIcons.escuela10;
      break;
    case 'estudiante1':
      return EniaIcons.estudiante1;
      break;
    case 'estudiantesgrupo':
      return EniaIcons.estudiantesgrupo;
      break;
    default:
      return Icons.local_hospital;
      break;
  }
}
