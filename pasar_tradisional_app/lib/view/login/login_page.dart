import 'dart:convert';
import 'dart:math';

// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasar_tradisional_app/helper/constant.dart';
import 'package:pasar_tradisional_app/helper/toast/Toast.dart';
import 'package:pasar_tradisional_app/model/login/ModelLogin.dart';
import 'package:pasar_tradisional_app/view/home/HomePage.dart';
import 'package:pasar_tradisional_app/view/phone_verif/continue_with_phone.dart';
import 'package:pasar_tradisional_app/view/register/register_page.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:tracking/helper/constant.dart';
import 'package:http/http.dart' as http;

// import 'package:tracking/view/maps.dart';
// import 'package:tracking/view/register/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _loginEmailController = new TextEditingController();
  TextEditingController _loginPasswordController = new TextEditingController();

  bool _privacyPolicy = false;
  var _stateButton = 0;

  var isLogin,
      idUser,
      usernameUser,
      emailUser,
      namaUser,
      telpUser,
      fotoUser,
      levelUser;

  ModelLogin modelLogin;
  bool _obscureText = true;

  Widget _buildUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _loginEmailController,
            keyboardType: TextInputType.emailAddress,
            style: kTextFieldStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: cPrimary,
              ),
              hintText: 'Masukkan Username',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _loginPasswordController,
            obscureText: _obscureText,
            style: kTextFieldStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              suffixIcon: _obscureText
                  ? GestureDetector(
                      child: Icon(
                        Icons.hdr_on,
                        color: cGrey1,
                      ),
                      onTap: _toggle,
                    )
                  : GestureDetector(
                      child: Icon(
                        Icons.hdr_off,
                        color: cGrey1,
                      ),
                      onTap: _toggle,
                    ),
              prefixIcon: Icon(
                Icons.lock,
                color: cPrimary,
              ),
              hintText: 'Masukkan Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Toast.show('Coming soon!', context, backgroundColor: cGrey1);
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Lupa Password',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildSetujuKebijakanPrivasiCheckbox() {
    return Container(
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: cPrimary),
            child: Checkbox(
              value: _privacyPolicy,
              checkColor: cWhite,
              activeColor: cPrimary,
              onChanged: (value) {
                setState(() {
                  _privacyPolicy = value;
                });
              },
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                'Setuju dengan Syarat & Ketentuan Pengunaan',
                style: kLabelStyleSmall,
              ),
              Text(
                'dan Kebijakan Privasi Pasar Tradisional',
                style: kLabelStyleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: MaterialButton(
        elevation: 5.0,
        onPressed: () {
          setState(() {
            if (_stateButton == 0) {
              animateButton();
            }
          });
          validateLogin();
        },
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: cPrimary,
        child: setUpButtonChild("MASUK"),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Belum punya akun? ',
              style: kLabelStyle,
            ),
            TextSpan(
              text: 'Daftar Sekarang',
              style: kLabelStyleBold,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      cWhite,
                      cWhite,
                      cWhite,
                      cWhite,
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 40.0,
                      right: 40.0,
                      top: 50.0,
                      bottom: 20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: cPrimary,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CircleAvatar(
                              backgroundColor: cPrimary,
                              radius: 50,
                              child: Image.asset(
                                "assets/images/holding-phone.png",
                                width: 50,
                                height: 50,
                              )),
                        ),
                        SizedBox(height: 10.0),
                        _buildUsernameTF(),
                        SizedBox(
                          height: 10.0,
                        ),
                        _buildPasswordTF(),
                        _buildForgotPasswordBtn(),
                        _buildSetujuKebijakanPrivasiCheckbox(),
                        _buildLoginBtn(),
                        _buildSignupBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void animateButton() {
    setState(() {
      _stateButton = 1;
    });
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void validateLogin() {
    String password = _loginPasswordController.text;
    String email = _loginEmailController.text;

    if (email.isNotEmpty || password.isNotEmpty) {
      if (!_privacyPolicy) {
        setState(() {
          _stateButton = 0;
        });

        Toast.show('Anda belum menyetujui kebijakan privasi.', context,
            backgroundColor: cYellow1);
      } else {
        actionLogin();
      }
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => LoginPage(),
      //     ));
    } else {
      setState(() {
        _stateButton = 0;
      });
      Toast.show('Email dan Password tidak boleh kosong.', context,
          backgroundColor: cYellow1);
    }
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

  void actionLogin() async {
    final response = await http.post(baseURL + endPointLogin, body: {
      'username': _loginEmailController.text,
      'password': _loginPasswordController.text,
    });
    var statusCode;
    if (response.statusCode == 200) {
      if (response.body != "") {
        modelLogin = modelLoginFromJson(response.body);
        var  message, status, role_id;
        var convertDataToJSON = json.decode(response.body);
        print("response = $convertDataToJSON");
        status = modelLogin.status;
        print("response = ${response.body}");
        if (status) {
          var data = modelLogin.data;
          message = convertDataToJSON['message'];
          isLogin = true;
          idUser = data[0].idUser;
          usernameUser = data[0].username;
          namaUser = data[0].namaLengkap;
          emailUser = data[0].email;
          telpUser = data[0].noTelp;
          fotoUser = data[0].foto;
          levelUser = data[0].level;
          savePrefUser();
          Toast.show(message, context, backgroundColor: cGreen);

          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
          Toast.dismiss();
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
    } else {
      print("else 3");
      Toast.show('Koneksi Terputus, Mohon Coba Lagi', context,
          backgroundColor: cRed);

      setState(() {
        _stateButton = 0;
      });
    }
  }

  savePrefUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('isLogin', isLogin.toString());
      prefs.setString('idLogin', idUser.toString());
      prefs.setString('usernameLogin', usernameUser.toString());
      prefs.setString('namaLogin', namaUser.toString());
      prefs.setString('emailLogin', emailUser.toString());
      prefs.setString('telpLogin', telpUser.toString());
      prefs.setString('fotoLogin', fotoUser.toString());
      prefs.setString('levelLogin', levelUser.toString());
    });
  }
}
