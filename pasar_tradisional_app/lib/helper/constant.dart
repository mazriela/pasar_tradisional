

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// const baseURL = 'http://wkwk.minjem.top/api/pasar/';
const baseURL = 'http://api.pasartradisional.id/api/pasar/';
const endPointRegister ="user/register";
const endPointLogin ="user/login";
const endtPointGetPasar ="pasar/get";
const endtPointGetKategoriPasar ="kategori/get";
const endtPointGetSubKategoriPasar ="kategori/get_sub";
const endtPointGetProduct ="produk/get";
const String endPointgetTruckList = baseURL+'list_truck';
const String endPointgetListTransaksi = baseURL+'list_transaksi';
const String endPointSaveOrder = baseURL+'simpan_transaksi';



int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  TextStyle _textstyle(
    Color warna,
    double ukuran,
    String fontFamily
  ) {
    return new TextStyle(color: warna, fontSize: ukuran, fontFamily:  fontFamily, );
  }

var cWhite =  Color(0xFFFFFFFF);
var cBlack =  Color(0xff222222);
var cPrimary =  Color(0xff073b55);
var cRed = Color(0xFFFF0000);
var cGreen = Color(0xFF00FF00);
var cGrey1 =  Color(0xFFC5C5C5);
var cGrey2 =  Color(0xFFB2B2B2);
var cGrey3 =  Color(0xFF9E9E9E);
var cGrey4 =  Color(0xFF878787);

var cYellow1 = Color(0xFFFeb80a);
var cYellow2 = Color(0xffffca45);
var cYellow3 = Color(0xfffad57a);
var cYellow4 = Color(0xfffeecc0);

// var cYellow2 = Color(0xFFFFDC3D);


const minimalTextSize = 12.0;


final kHintTextStyle = TextStyle(
  color: cGrey2,
  fontFamily: 'OpenSans',
);

final kLabelStyleSmall = TextStyle(
  color: cPrimary,
  fontSize: 12,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: cPrimary,
  fontFamily: 'OpenSans',
);

final kLabelStyleBold = TextStyle(
  color: cPrimary,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);


final kTextFieldStyle = TextStyle(
  color: cPrimary,
  fontSize: 16,
  fontFamily: 'OpenSans',
);


final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
final regularTextStyle = baseTextStyle.copyWith(
    color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400);

final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 16.0);
final headerTextStyle = baseTextStyle.copyWith(
    color: Colors.white, fontSize:18.0, fontWeight: FontWeight.w600);

final toggleButtonStyle = baseTextStyle.copyWith(
    color: Colors.lightBlue, fontSize: 15.0, fontWeight: FontWeight.w600);





final kBoxDecorationStyle = BoxDecoration(
  color: Colors.grey[100],
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

