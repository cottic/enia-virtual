import 'package:fluffychat/stats_dashboard/models/drop_down_item_model.dart';
import 'package:flutter/material.dart';

final List<DropDownItemsModel> dropdownItems = [
  DropDownItemsModel(1, 'Todas'),
  DropDownItemsModel(2, 'Buenos Aires'),
  DropDownItemsModel(3, 'CABA'),
  DropDownItemsModel(4, 'Catamarca'),
  DropDownItemsModel(5, 'Chaco'),
  DropDownItemsModel(6, 'Corrientes'),
  DropDownItemsModel(7, 'Entre Ríos'),
  DropDownItemsModel(8, 'Formosa'),
  DropDownItemsModel(9, 'Jujuy'),
  DropDownItemsModel(10, 'La Rioja'),
  DropDownItemsModel(11, 'Misiones'),
  DropDownItemsModel(12, 'Santiago del estero'),
  DropDownItemsModel(13, 'Salta'),
  DropDownItemsModel(14, 'Tucumán'),
];

List<DropdownMenuItem<DropDownItemsModel>> buildDropDownMenuItems(
    List listItems) {
  List<DropdownMenuItem<DropDownItemsModel>> items = List();
  for (DropDownItemsModel listItem in listItems) {
    items.add(
      DropdownMenuItem(
        child: Text(listItem.name),
        value: listItem,
      ),
    );
  }
  return items;
}

String getProvinciaValue(int value) {
  switch (value) {
    case 1:
      return '';
      break;
    case 2:
      return '&provincia=bue';
      break;
    case 3:
      return '&provincia=cab';
      break;
    case 4:
      return '&provincia=cat';
      break;
    case 5:
      return '&provincia=cha';
      break;
    case 6:
      return '&provincia=cor';
      break;
    case 7:
      return '&provincia=ent';
      break;
    case 8:
      return '&provincia=for';
      break;
    case 9:
      return '&provincia=juj';
      break;
    case 10:
      return '&provincia=rio';
      break;
    case 11:
      return '&provincia=mis';
      break;
    case 12:
      return '&provincia=stg';
      break;
    case 13:
      return '&provincia=sal';
      break;
    case 14:
      return '&provincia=tuc';
      break;

    default:
  }
  ;
}
