import 'package:fluffychat/stats_dashboard/models/drop_down_item_model.dart';
import 'package:flutter/material.dart';

final List<DropDownItemsModel> dropdownItems = [
  DropDownItemsModel(1, 'TODAS', true),

  DropDownItemsModel(2, 'BUENOS AIRES', true),
  DropDownItemsModel(15, 'Almirante Brown', false),
  DropDownItemsModel(16, 'Lanús', false),
  DropDownItemsModel(17, 'Morón', false),
  DropDownItemsModel(18, 'San Isidro', false),
  DropDownItemsModel(19, 'San Martin', false),
  DropDownItemsModel(20, 'Quilmes', false),

  DropDownItemsModel(3, 'CABA', true),

  DropDownItemsModel(4, 'CATAMARCA', true),
  DropDownItemsModel(21, 'CATAMARCA Capital', false),
  DropDownItemsModel(22, 'Belen', false),
  DropDownItemsModel(23, 'Valle Viejo', false),

  DropDownItemsModel(5, 'CHACO', true),
  DropDownItemsModel(24, 'San Fernando', false),
  DropDownItemsModel(25, 'Gral Guemes', false),
  DropDownItemsModel(26, 'Chacabuco', false),

  DropDownItemsModel(6, 'CORRIENTES', true),
  DropDownItemsModel(27, 'CORRIENTES Capital', false),
  DropDownItemsModel(28, 'Goya', false),

  DropDownItemsModel(7, 'ENTRE RÍOS', true),
  DropDownItemsModel(29, 'Paraná', false),
  DropDownItemsModel(30, 'Concordia', false),
  DropDownItemsModel(31, 'Gualeguaychu', false),

  DropDownItemsModel(8, 'FORMOSA', true),
  DropDownItemsModel(32, 'FORMOSA Capital', false),
  DropDownItemsModel(33, 'Pilcomayo', false),

  DropDownItemsModel(9, 'JUJUY', true),
  DropDownItemsModel(34, 'Manuel Belgrano', false),
  DropDownItemsModel(35, 'San Pedro', false),

  DropDownItemsModel(10, 'LA RIOJA', true),
  DropDownItemsModel(36, 'LA RIOJA Capital', false),
  DropDownItemsModel(37, 'Chilecito', false),
  DropDownItemsModel(38, 'Rosario Vera Penialoza', false),

  DropDownItemsModel(11, 'MISIONES', true),
  DropDownItemsModel(39, 'MISIONES Capital', false),
  DropDownItemsModel(40, 'Guarani', false),
  DropDownItemsModel(41, 'Oberá', false),

  DropDownItemsModel(12, 'SALTA', true),
  DropDownItemsModel(42, 'SALTA Capital', false),
  DropDownItemsModel(43, 'Oran', false),

  DropDownItemsModel(13, 'SANTIAGO DEL ESTERO', true),
  DropDownItemsModel(44, 'SANTIAGO DEL ESTERO Capital', false),
  DropDownItemsModel(45, 'Banda', false),
  DropDownItemsModel(46, 'Rio Hondo', false),
  DropDownItemsModel(47, 'D. Robles', false),

  DropDownItemsModel(14, 'TUCUMÁN', true),
  DropDownItemsModel(48, 'TUCUMÁN Capital', false),
  DropDownItemsModel(49, 'Tafi Viejo', false),
  DropDownItemsModel(50, 'Cruz Alta', false),
];

List<DropdownMenuItem<DropDownItemsModel>> buildDropDownMenuItems(
    List listItems) {
  // ignore: omit_local_variable_types
  List<DropdownMenuItem<DropDownItemsModel>> items = [];
  for (DropDownItemsModel listItem in listItems) {
    items.add(
      DropdownMenuItem(
        child: listItem.isPrimay
            ? Text(
                listItem.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  listItem.name,
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
              ),
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
      return '&provincia=sal';
      break;
    case 13:
      return '&provincia=stg';
      break;
    case 14:
      return '&provincia=tuc';
      break;

    case 15:
      return '&provincia=bue-altbr';
      break;
    case 16:
      return '&provincia=bue-lanus';
      break;
    case 17:
      return '&provincia=bue-moron';
      break;
    case 18:
      return '&provincia=bue-sisidro';
      break;
    case 19:
      return '&provincia=bue-smartin';
      break;
    case 20:
      return '&provincia=bue-quilmes';
      break;

    case 21:
      return '&provincia=cat-capit';
      break;
    case 22:
      return '&provincia=cat-belen';
      break;
    case 23:
      return '&provincia=cat-vviejo';
      break;

    case 24:
      return '&provincia=cha-sferan';
      break;
    case 25:
      return '&provincia=cha-guemes';
      break;
    case 26:
      return '&provincia=cha-chacab';
      break;

    case 27:
      return '&provincia=cor-capit';
      break;
    case 28:
      return '&provincia=cor-goya';
      break;

    case 29:
      return '&provincia=ent-parana';
      break;
    case 30:
      return '&provincia=ent-concor';
      break;
    case 31:
      return '&provincia=ent-gualchu';
      break;

    case 32:
      return '&provincia=for-capit';
      break;
    case 33:
      return '&provincia=for-pilco';
      break;

    case 34:
      return '&provincia=juj-belgrano';
      break;
    case 35:
      return '&provincia=juj-spedro';
      break;

    case 36:
      return '&provincia=rio-capit';
      break;
    case 37:
      return '&provincia=rio-chile';
      break;
    case 38:
      return '&provincia=rio-verapenia';
      break;

    case 39:
      return '&provincia=mis-capit';
      break;
    case 40:
      return '&provincia=mis-guarani';
      break;
    case 41:
      return '&provincia=mis-obera';
      break;

    case 42:
      return '&provincia=sal-capit';
      break;
    case 43:
      return '&provincia=sal-oran';
      break;

    case 44:
      return '&provincia=stg-capit';
      break;
    case 45:
      return '&provincia=stg-banda';
      break;
    case 46:
      return '&provincia=stg-riohon';
      break;
    case 47:
      return '&provincia=stg-drobles';
      break;

    case 48:
      return '&provincia=tuc-capit';
      break;
    case 49:
      return '&provincia=tuc-tafiv';
      break;
    case 50:
      return '&provincia=tuc-cruzalta';
      break;

    default:
      return '';
  }
}
