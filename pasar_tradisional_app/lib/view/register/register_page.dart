import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasar_tradisional_app/helper/constant.dart';
import 'package:pasar_tradisional_app/view/login/login_page.dart';
import 'package:pasar_tradisional_app/view/phone_verif/continue_with_phone.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:tracking/helper/constant.dart';
import 'package:http/http.dart' as http;

// import 'package:tracking/view/maps.dart';
// import 'package:tracking/view/register/register_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _registerUsernameController =
      new TextEditingController();
  TextEditingController _registerPhoneController = new TextEditingController();
  TextEditingController _registerEmailController = new TextEditingController();
  TextEditingController _registerPasswordController =
      new TextEditingController();

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  var _stateButton = 0;
  bool _privacyPolicy = false;
  bool _obscureText = true;

  var isLogin, usernameUser, emailUser, noTelpUser, passwordUser;

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
          
          child: TextFormField(
            controller: _registerUsernameController,
            keyboardType: TextInputType.text,
            style: kTextFieldStyle,
            validator: validateName,
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

  Widget _buildPhoneTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nomor Telepon',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          
          child: TextFormField(
            controller: _registerPhoneController,
            keyboardType: TextInputType.phone,
            maxLength: 13,
            style: kTextFieldStyle,
            validator: validateMobile,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 20.0),
                prefixIcon: Icon(
                  Icons.phone,
                  color: cPrimary,
                ),
                hintText: 'Masukkan No Telepon',
                hintStyle: kHintTextStyle),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          
          child: TextFormField(
            controller: _registerEmailController,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            style: kTextFieldStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: cPrimary,
              ),
              hintText: 'Masukkan Email',
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
          child: TextFormField(
            controller: _registerPasswordController,
            obscureText: _obscureText,
            style: kTextFieldStyle,
            validator: validatePassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),

              suffixIcon: _obscureText ? GestureDetector(child: Icon(Icons.hdr_on, color: cGrey1,), onTap: _toggle,) : GestureDetector(child: Icon(Icons.hdr_off, color: cGrey1,), onTap: _toggle,),
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

  Widget _buildRegisterBtn() {
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
          validateRegister();
        },
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: cPrimary,
        child: setUpButtonChild("DAFTAR"),
      ),
    );
  }

  Widget _buildSignipBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Sudah punya akun? ',
              style: kLabelStyle,
            ),
            TextSpan(
              text: 'Login Sekarang',
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
                          'Sign up',
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
                        Form(
                          key: _key,
                          autovalidate: _validate,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10.0),
                              _buildUsernameTF(),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildEmailTF(),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildPhoneTF(),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildPasswordTF(),
                            ],
                          ),
                        ),
                        _buildRegisterBtn(),
                        _buildSignipBtn(),
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

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void animateButton() {
    setState(() {
      _stateButton = 1;
    });
  }

  void validateRegister() {


    usernameUser = _registerUsernameController.text;
    noTelpUser = _registerPhoneController.text;
    emailUser = _registerEmailController.text;
    passwordUser = _registerPasswordController.text;

    actionRegister();

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

  String validateName(String value) {
    if (value.length == 0) {
      return "Username tidak boleh kosong";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "No Telepon tidak boleh kosong";
    } else if (value.length < 10) {
      return "No Telepon tidak boleh kurang dari 10 digit";
    } else if (!regExp.hasMatch(value)) {
      return "No telepon harus angka!";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email Tidak Boleh Kosong";
    } else if (!regExp.hasMatch(value)) {
      return "Format email salah!";
    } else {
      return null;
    }
  }



  String validatePassword(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?).{6,}$';
    RegExp regExp = new RegExp(pattern);

    if(value.length == 0){
      return "Password Tidak Boleh Kosong";
    } else if (value.length < 6){
      return "Password tidak boleh kurang dari 6";

    }else if (!regExp.hasMatch(value)){
      return " Password setidaknya harus terdiri dari 1 angka dan\n huruf kapital";
    } else {
      return null;
    }

  }

  void actionRegister() {

    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print("Name $usernameUser");
      print("Mobile $noTelpUser");
      print("Email $emailUser");
      _stateButton = 0;
      if (_stateButton == 0) {
        animateButton();
        savePrefRegister();
        // setState(() {
        //   _stateButton = 0;
        // });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ContinueWithPhone()));
        _stateButton = 0;
      }
    } else {
      // validation error
      setState(() {
        _validate = true;
        _stateButton = 0;
      });
    }
  }

  savePrefRegister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('isLogin', isLogin.toString());
      prefs.setString('email', emailUser.toString());
      prefs.setString('username', usernameUser.toString());
      prefs.setString('telp', noTelpUser.toString());
      prefs.setString('pass', passwordUser.toString());
    });
  }
}
