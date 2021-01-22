import 'package:agconnect_auth/agconnect_auth.dart';
import 'package:huawei_account/huawei_account.dart';
import 'package:flutter/material.dart';
import '../ui/auth_button.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> logs = [];

  HmsAuthHuaweiId _id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("HMS Account"),
          backgroundColor: Colors.blueAccent,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 20),
              Column(
                children: [
                  HmsAuthButton(
                      onPressed: _signIn,
                      buttonColor: AuthButtonBackground.RED),
                  //authButton("SILENT SIGN IN", _silentSignIn),
                  authButton("SIGN OUT", _signOut),
                  authButton("Quitar autorización", _revokeAuthorization),
                  authButton("SMS VERIFICATION", _smsVerification)
                ],
              ),
              Divider(indent: 15, endIndent: 15, color: Colors.blueGrey),
              Expanded(
                  child: GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    logs.clear();
                  });
                },
                child: Container(
                  child: ListView.builder(
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(logs[index],
                            style: TextStyle(color: Colors.black54)),
                      );
                    },
                  ),
                ),
              )),
            ],
          ),
        ));
  }

  _signIn() async {
    // This parameter is optional. You can run the method with default options.
    final helper = new HmsAuthParamHelper();
    helper
      ..setIdToken()
      ..setAccessToken()
      ..setAuthorizationCode()
      ..setEmail()
      ..setProfile()
      ..setId();
    try {
      _id = await HmsAuthService.signIn(authParamHelper: helper);
      _addToLogs("FROM SIGN IN: ${_id.displayName}");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _signOut() async {
    try {
      final bool result = await HmsAuthService.signOut();
      _addToLogs("FROM SIGN OUT: $result");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _silentSignIn() async {
    try {
      final HmsAuthHuaweiId id = await HmsAuthService.silentSignIn();
      _addToLogs("FROM SILENT SIGN IN: ${id.displayName}");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _revokeAuthorization() async {
    try {
      final bool result = await HmsAuthService.revokeAuthorization();
      _addToLogs("FROM REVOKE AUTHORIZATION: $result");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _smsVerification() async {
    final String hashcode = await HmsSmsManager.obtainHashcode();

    print(hashcode);

    HmsSmsManager.smsVerification(({errorCode, message}) {
      if (message != null) {
        setState(() {
          _addToLogs(message);
        });
        print("Received message: $message");
      } else {
        print("Error: $errorCode");
      }
    });
  }

  _addToLogs(String s) {
    setState(() {
      logs.add(s);
    });
  }

  celular() {
    //HmsSmsManager.smsVerification(({errorCode, message}) => null);
    VerifyCodeSettings settings =
        VerifyCodeSettings(VerifyCodeAction.registerLogin, sendInterval: 30);
    PhoneAuthProvider.requestVerifyCode('+593', '989540235', settings)
        .then((result) async {
      print(result.toString());
    });
  }
}
