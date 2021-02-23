import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pasar_tradisional_app/helper/constant.dart';
import 'package:pasar_tradisional_app/helper/toast/Toast.dart';
import 'package:pasar_tradisional_app/view/login/login_page.dart';
import 'package:pasar_tradisional_app/view/phone_verif/verifty_phone.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'numeric_pad.dart';

class ContinueWithPhone extends StatefulWidget {
  @override
  _ContinueWithPhoneState createState() => _ContinueWithPhoneState();
}

class _ContinueWithPhoneState extends State<ContinueWithPhone> {
  String phoneNumber = "";

  String phoneNo, smssent, verificationId;
  var user;
  var _auth;
  SharedPreferences prefs;
  var _stateButton = 0;

  get verifiedSuccess => null;

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  void getUserPref() async {
    prefs = await SharedPreferences.getInstance();
    String strPhoneNumber = prefs.get("telp");
    if (strPhoneNumber[0].contains("0")) {
      phoneNumber = replaceCharAt(strPhoneNumber, 0, "");
    } else {
      phoneNumber = strPhoneNumber;
    }
  }


  void animateButton() {
    setState(() {
      _stateButton = 1;
    });
  }

  Future<void> verfiyPhone() async {
    if(_stateButton == 0){
      animateButton();
    }
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
      this.verificationId = verId;

      setState(() {
        _stateButton = 0;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VerifyPhone(
                  phoneNumber: phoneNumber,
                  verificaationID: verificationId,
                )),
      );
      // smsCodeDialoge(context).then((value){
      //   print("Code Sent");
      // });
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {};
    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException e) {
      print('${e.message}');
      setState(() {
        _stateButton = 0;
      });
      Toast.show(e.message, context, backgroundColor: cRed);
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+62$phoneNumber",
      timeout: const Duration(seconds: 60),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future<bool> smsCodeDialoge(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter OTP'),
            content: TextField(
              onChanged: (value) {
                this.smssent = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  user = _auth.currentUser;
                  if (user != null) {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  } else {
                    Navigator.of(context).pop();
                    signIn(smssent);
                  }
                },
                child: Text(
                  'done',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          );
        });
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }).catchError((e) {
      print(e);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserPref();
    Firebase.initializeApp().whenComplete(() {
      _auth = FirebaseAuth.instance;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.close,
          size: 30,
          color: Colors.black,
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
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFF7F7F7),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 130,
                    child: Image.asset('assets/images/holding-phone.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 64),
                    child: Text(
                      "Kamu akan menerima 6 digit code berikutnya.",
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF818181),
                      ),
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
                  Container(
                    width: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Enter your phone",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "(+62) $phoneNumber",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        verfiyPhone();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: cPrimary,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Center(child: setUpButtonChild("Kirim")),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          NumericPad(
            onNumberSelected: (value) {
              setState(() {
                if (value != -1) {
                  if (phoneNumber.length < 12) {
                    phoneNumber = phoneNumber + value.toString();
                  }
                } else {
                  phoneNumber =
                      phoneNumber.substring(0, phoneNumber.length - 1);
                }
              });
            },
          ),
        ],
      )),
    );
  }
}
