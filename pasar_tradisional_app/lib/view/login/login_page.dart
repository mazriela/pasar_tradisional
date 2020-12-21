import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pasar_tradisional_app/helper/constant.dart';

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
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool _rememberMe = false;
  var _stateButton = 0;

  var isLogin, idUser, emailUser, namaUser, telpUser, noKtpUser;

  Widget _buildEmailTF() {
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
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: kTextFieldStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: cBlack,
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
            controller: passwordController,
            obscureText: true,
            style: kTextFieldStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: cBlack,
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
          showToastComingSoon();
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
            data: ThemeData(unselectedWidgetColor: cBlack),
            child: Checkbox(
              value: _rememberMe,
              checkColor: cWhite,
              activeColor: cBlack,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                'Setuju dengan Syarat & Ketentuan Pengunaan',
                style: kLabelStyleSmall,
              ),  Text(
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
          actionLogin();
        },
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: cBlack,
        child: setUpButtonChild("LOGIN"),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => RegisterPage()),
        // );
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
                            color: cBlack,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CircleAvatar(
                              backgroundColor: cBlack,
                              radius: 50,
                              child: Image.asset(
                                "assets/images/holding-phone.png",
                                width: 50,
                                height: 50,
                              )),
                        ),
                        SizedBox(height: 10.0),
                        _buildEmailTF(),
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

  void showToastComingSoon() {
    Fluttertoast.showToast(
        msg: "This feature is under maintenance",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: cGrey4,
        textColor: cWhite,
        fontSize: 16.0);
  }

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: cGrey4,
        textColor: cWhite,
        fontSize: 16.0);
  }

  void animateButton() {
    setState(() {
      _stateButton = 1;
    });
  }

  void actionLogin() {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty || password.isNotEmpty) {
      print("do login");
    } else {
      setState(() {
        _stateButton = 0;
      });
      showToast("Email dan Password tidak boleh kosong");
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

//   void login() async {
//     final response = await http.post(baseURL + endPointLogin, body: {
//       'email': emailController.text,
//       'password': passwordController.text,
//     });
//     var statusCode;
//     if (response.body != "") {
//       var convertJSON, data, message, status, role_id;
//       var convertDataToJSON = json.decode(response.body);
//       convertJSON = convertDataToJSON;
//       data = convertDataToJSON['data'];
//       message = convertDataToJSON['message'];
//       status = convertDataToJSON['status'];
//       if (status == 1) {
//         role_id = data[0]['role_id'].toString();
//         print(role_id);
//         if(role_id == "2"){
//           showToast(message);
//           setState(() {
//             _stateButton = 2;
//           });
//           isLogin = true;
//           idUser = data[0]['_id'];
//           emailUser = data[0]['email'];
//           namaUser = data[0]['nama'];
//           telpUser = data[0]['telp'];
//           noKtpUser = data[0]['no_ktp'];
//           savePrefDriver();
//           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MapsView()));
//         } else {
//           showToast("Username/Password Salah");
//           setState(() {
//             _stateButton = 0;
//           });
//         }
//
//       } else {
//         showToast(message);
//         setState(() {
//           _stateButton = 0;
//         });
//       }
//     } else {
//       setState(() {
//         _stateButton = 0;
//       });
//     }
// //    Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
//   }

  savePrefDriver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('isLogin', isLogin.toString());
      prefs.setString('id', idUser.toString());
      prefs.setString('email', emailUser.toString());
      prefs.setString('nama', namaUser.toString());
      prefs.setString('telp', telpUser.toString());
      prefs.setString('no_ktp', noKtpUser.toString());
    });
  }
}
