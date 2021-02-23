import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasar_tradisional_app/helper/constant.dart';
import 'package:pasar_tradisional_app/helper/toast/Toast.dart';
import 'package:pasar_tradisional_app/model/register/ModelRegister.dart';
import 'package:pasar_tradisional_app/view/login/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'numeric_pad.dart';

class VerifyPhone extends StatefulWidget {
  final String phoneNumber, verificaationID;

  VerifyPhone({@required this.phoneNumber, @required this.verificaationID});

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  var _auth;
  var user;
  var _stateButton = 0;

  String code = "";

  ModelRegister modelRegister;
  SharedPreferences prefs;
  var strUsername, strEmail, strNoTelepon, strPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserPref();
    Firebase.initializeApp().whenComplete(() {
      _auth = FirebaseAuth.instance;
      setState(() {});
    });
    print("ID ${widget.verificaationID}");
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: widget.verificaationID,
      smsCode: smsCode,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      // Toast.show('Verifikasi Berhasil.', context, backgroundColor: cYellow1);
      // Navigator.push(context, MaterialPageRoute(
      //   builder: (context) => LoginPage(),),
      // );
      setState(() {
        _stateButton = 0;
      });
      sendRegister();
    }).catchError((e) {
      print(e);
      Toast.show('Kode tidak sesuai,\nsilahkan coba lagi', context,
          backgroundColor: cYellow1);
    });
  }

  Widget setUpButtonChild(String caption) {
    if (_stateButton == 0) {
      return new Text(
        caption,
        style: TextStyle(
          color: cWhite,
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (_stateButton == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(cGrey4),
      );
    } else {
      return new Text(
        caption,
        style: TextStyle(
          letterSpacing: 1.5,
          fontSize: 18.0,
          color: cWhite,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  void animateButton() {
    setState(() {
      _stateButton = 1;
    });
  }

  void getUserPref() async {
    prefs = await SharedPreferences.getInstance();
    strUsername = prefs.get("username");
    strEmail = prefs.get("email");
    strNoTelepon = prefs.get("telp");
    strPassword = prefs.get("pass");
  }

  void sendRegister() async {
    final response = await http.post(baseURL + endPointRegister, body: {
      'username': strUsername,
      'email': strEmail,
      'no_telp': strNoTelepon,
      'password': strPassword,
    });
    var status, message, data;

    // if (response.statusCode == 200) {

    if (response.statusCode == 200) {
      if (response.body != "") {
        modelRegister = modelRegisterFromJson(response.body);
        status = modelRegister.status;
        message = modelRegister.message;
        print("response = ${response.body}");
        if (status) {
          setState(() {
            _stateButton = 0;
          });
          data = modelRegister.data;
          print(data.toString());
          removesRegisterValues();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        } else {
          print("else 1");
          Toast.show(message, context, backgroundColor: cRed);
          setState(() {
            _stateButton = 0;
          });
        }
      } else {
        print("else 2");
        Toast.show('Koneksi Terputus, Mohon Coba Lagi', context,
            backgroundColor: cRed);

        setState(() {
          _stateButton = 0;
        });
      }
    }
  }

  removesRegisterValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("username");
    prefs.remove("email");
    prefs.remove("telp");
    prefs.remove("pass");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Verifikasi Nomor Telepon",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        "Kode verifikasi telah dikirim ke no",
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF818181),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Text(
                        "(+62) ${widget.phoneNumber}",
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF818181),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildCodeNumberBox(
                            code.length > 0 ? code.substring(0, 1) : ""),
                        buildCodeNumberBox(
                            code.length > 1 ? code.substring(1, 2) : ""),
                        buildCodeNumberBox(
                            code.length > 2 ? code.substring(2, 3) : ""),
                        buildCodeNumberBox(
                            code.length > 3 ? code.substring(3, 4) : ""),
                        buildCodeNumberBox(
                            code.length > 4 ? code.substring(4, 5) : ""),
                        buildCodeNumberBox(
                            code.length > 5 ? code.substring(5, 6) : ""),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Tidak menerima kode?",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF818181),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Resend the code to the user");
                          },
                          child: Text(
                            "Kirim Ulang",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_stateButton == 0) {
                          animateButton();
                          if (user != null) {
                            sendRegister();
                          } else {
                            signIn(code);
                          }
                        }

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: cPrimary,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: setUpButtonChild("Verifikasi dan Buat Akun"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          NumericPad(
            onNumberSelected: (value) {
              print(value);
              setState(() {
                if (value != -1) {
                  if (code.length < 6) {
                    code = code + value.toString();
                  }
                } else {
                  code = code.substring(0, code.length - 1);
                }
                print(code);
              });
            },
          ),
        ],
      )),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: SizedBox(
        width: 45,
        height: 45,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F5FA),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75))
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
