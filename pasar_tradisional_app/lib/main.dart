import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pasar_tradisional_app/helper/constant.dart';
import 'package:pasar_tradisional_app/view/login/login_page.dart';
import 'package:pasar_tradisional_app/view/phone_verif/continue_with_phone.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pasar Tradisional',
      theme: ThemeData(
        primaryColor: cPrimary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.rubikTextTheme(),

      ),
      home: LoginPage(),
    );
  }
}

