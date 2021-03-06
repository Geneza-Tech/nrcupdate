import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/App/Sign_in/Login.dart';
import 'package:flutter_app/App/Sign_in/passcodepage.dart';
//import 'package:flutter_app/App/Sign_in/Homepage.dart';

import 'package:flutter_lock_screen/flutter_lock_screen.dart';
//import 'Homepage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'selectmonth.dart';

class passcodsetepage extends StatefulWidget {
  passcodsetepage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _passcodsetepageState createState() => new _passcodsetepageState();
}

class _passcodsetepageState extends State<passcodsetepage> {
  bool isFingerprint;

  @override
  void initState() {
    super.initState();
  }

  Future<Null> biometrics() async {
    final LocalAuthentication auth = new LocalAuthentication();
    bool authenticated = false;

    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: false);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    if (authenticated) {
      setState(() {
        isFingerprint = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var myPass = [0, 0, 0, 0];
/* {"pin":[]} */
    return LockScreen(
        title: "Set Pin",
        passLength: myPass.length,
        // fingerPrintImage: "assets/images/fin.png",
        bgImage: "assets/images/Black.png",
        showFingerPass: false,
        numColor: Colors.blue,
        fingerVerify: false,
        
        borderColor: Colors.white,
        showWrongPassDialog: true,
        wrongPassContent: "Wrong pass please try again.",
        wrongPassTitle: "Opps!",
        wrongPassCancelButtonText: "Cancel",
        passCodeVerify: (passcode) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          myPass = passcode;
          String listToSting = jsonEncode({"pin": myPass});
          await prefs.setString('pin', listToSting);
          await prefs.setBool("isPinSet", true);
          return true;
        },
        onSuccess: () async {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (BuildContext context) {
            return passcodepage();
          }));
        });
  }
}

// import 'package:flutter/material.dart';
// import 'package:passcode_screen/circle.dart';
// import 'package:passcode_screen/keyboard.dart';
// import 'package:passcode_screen/passcode_screen.dart';
// import 'dart:async';
//
// const storedPasscode = '123456';
//
// class passcodsetepage extends StatefulWidget {
//   @override
//   _passcodsetepageState createState() => _passcodsetepageState();
// }
//
// class _passcodsetepageState extends State<passcodsetepage> {
//
//   final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();
//
//   bool isAuthenticated = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//       title: Text('passcode password'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Column(
//               children: [
//                 Text('You are ${isAuthenticated ? '' : 'NOT'} authenticated'),
//               ],
//             ),
//             _defaultLockScreenButton(context),
//            // _customColorsLockScreenButton(context)
//           ],
//         ),
//       ),
//     );
//   }
//
//   _defaultLockScreenButton(BuildContext context) => MaterialButton(
//     color: Theme.of(context).primaryColor,
//     child: Text('set your  Lock '),
//     onPressed: () {
//       _showLockScreen(
//         context,
//         opaque: false,
//         cancelButton: Text(
//           'Cancel',
//           style: const TextStyle(fontSize: 16, color: Colors.white),
//           semanticsLabel: 'Cancel',
//         ),
//       );
//     },
//   );
//
//   // _customColorsLockScreenButton(BuildContext context) {
//   //   final size = MediaQuery.of(context).size;
//   //   return MaterialButton(
//   //     color: Theme.of(context).primaryColor,
//   //     child: Text('Open Custom Lock Screen'),
//   //     onPressed: () {
//   //       _showLockScreen(context,
//   //           opaque: false,
//   //           circleUIConfig: CircleUIConfig(borderColor: Colors.blue, fillColor: Colors.blue, circleSize: 30),
//   //           keyboardUIConfig: KeyboardUIConfig(digitBorderWidth: 2, primaryColor: Colors.blue),
//   //           cancelButton: Icon(
//   //             Icons.arrow_back,
//   //             color: Colors.blue,
//   //           ),
//   //           digits: ['???', '???', '???', '???', '???', '???', '???', '???', '???', '???']);
//   //     },
//   //   );
//   // }
//
//   _showLockScreen(BuildContext context,
//       {bool opaque,
//         CircleUIConfig circleUIConfig,
//         KeyboardUIConfig keyboardUIConfig,
//         Widget cancelButton,
//         List<String> digits}) {
//     Navigator.push(
//         context,
//         PageRouteBuilder(
//           opaque: opaque,
//           pageBuilder: (context, animation, secondaryAnimation) => PasscodeScreen(
//             title: Text(
//               'Enter App Passcode',
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.white, fontSize: 28),
//             ),
//
//             circleUIConfig: circleUIConfig,
//             keyboardUIConfig: keyboardUIConfig,
//             passwordEnteredCallback: _onPasscodeEntered,
//             cancelButton: cancelButton,
//             deleteButton: Text(
//               'Delete',
//               style: const TextStyle(fontSize: 16, color: Colors.white),
//               semanticsLabel: 'Delete',
//             ),
//             shouldTriggerVerification: _verificationNotifier.stream,
//             backgroundColor: Colors.black.withOpacity(0.8),
//             cancelCallback: _onPasscodeCancelled,
//             digits: digits,
//             passwordDigits: 6,
//             bottomWidget: _buildPasscodeRestoreButton(),
//           ),
//         ));
//
//   }
//
//   _onPasscodeEntered(String enteredPasscode) {
//     bool isValid = storedPasscode == enteredPasscode;
//     _verificationNotifier.add(isValid);
//     if (isValid) {
//       setState(() {
//         this.isAuthenticated = isValid;
//       });
//     }
//   }
//
//   _onPasscodeCancelled() {
//     Navigator.maybePop(context);
//   }
//
//   @override
//   void dispose() {
//     _verificationNotifier.close();
//     super.dispose();
//   }
//
//   _buildPasscodeRestoreButton() => Align(
//     alignment: Alignment.bottomCenter,
//     child: Container(
//       margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
//       child: FlatButton(
//         child: Text(
//           " Forgot passcode",
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300),
//         ),
//
//         splashColor: Colors.white.withOpacity(0.4),
//         highlightColor: Colors.white.withOpacity(0.2),
//         onPressed: _resetAppPassword,
//       ),
//
//
//     ),
//   );
//
//   _resetAppPassword() {
//     Navigator.maybePop(context).then((result) {
//       if (!result) {
//         return;
//       }
//       _showRestoreDialog(() {
//         Navigator.maybePop(context);
//         //TODO: Clear your stored passcode here
//       });
//     });
//   }
//
//   _showRestoreDialog(VoidCallback onAccepted) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             "Reset passcode",
//             style: const TextStyle(color: Colors.black87),
//           ),
//
//           content: Text(
//             "Passcode reset is a non-secure operation!\n\nConsider removing all user data if this action performed.",
//             style: const TextStyle(color: Colors.black87),
//           ),
//           actions: <Widget>[
//             // usually buttons at the bottom of the dialog
//             FlatButton(
//               child: Text(
//                 "Cancel",
//                 style: const TextStyle(fontSize: 18),
//               ),
//               onPressed: () {
//                 Navigator.maybePop(context);
//               },
//             ),
//             FlatButton(
//               child: Text(
//                 "Go To Home",
//                 style: const TextStyle(fontSize: 10),
//               ),
//               onPressed: () {
//                 Navigator.maybePop(context);
//               },
//             ),
//
//
//           ],
//         );
//       },
//     );
//   }
//
// }
