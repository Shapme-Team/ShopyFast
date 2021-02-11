import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../home/home.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _verificationId;
  final SmsAutoFill _autoFill = SmsAutoFill();

  void showSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void verifyPhoneNumber() async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      showSnackbar(
          "Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showSnackbar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackbar("verification code: " + verificationId);
      _verificationId = verificationId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNumberController.text,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackbar("Failed to Verify Phone Number: $e");
    }
  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;

      showSnackbar("Successfully signed in UID: ${user.uid}");
      if (user != null) {
        print('pushing');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      user: user,
                    )));
      }
    } catch (e) {
      showSnackbar("Failed to sign in: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('ShopyFast'),
        ),
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                        labelText: 'Phone number (+xx xxx-xxx-xxxx)'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: RaisedButton(
                        child: Text("Get current number"),
                        onPressed: () async => {
                              _phoneNumberController.text = await _autoFill.hint
                            },
                        color: Colors.greenAccent[700]),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: RaisedButton(
                      color: Colors.greenAccent[400],
                      child: Text("Verify Number"),
                      onPressed: () async {
                        verifyPhoneNumber();
                      },
                    ),
                  ),
                  TextFormField(
                    controller: _smsController,
                    decoration:
                        const InputDecoration(labelText: 'Verification code'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    alignment: Alignment.center,
                    child: RaisedButton(
                        color: Colors.greenAccent[200],
                        onPressed: () async {
                          signInWithPhoneNumber();
                        },
                        child: Text("Sign in")),
                  ),
                ],
              )),
        ));
  }
}

// class LoginScreen extends StatelessWidget {
//   final _phoneController = TextEditingController();
//   final _codeController = TextEditingController();

//   Future<bool> loginUser(String phone, BuildContext context) async {
//     FirebaseAuth _auth = FirebaseAuth.instance;

//     _auth.verifyPhoneNumber(
//       phoneNumber: phone,
//       timeout: Duration(seconds: 60),
//       verificationCompleted: (AuthCredential credential) async {
//         Navigator.of(context).pop();

//         UserCredential result = await _auth.signInWithCredential(credential);

//         User user = result.user;

//         if (user != null) {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => HomeScreen(
//                         user: user,
//                       )));
//         } else {
//           print("Error");
//         }

//         //This callback would gets called when verification is done auto maticlly
//       },
//       verificationFailed: (Exception exception) {
//         print(exception);
//       },
//       codeSent: (String verificationId, [int forceResendingToken]) {
//         showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text("Give the code?"),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     TextField(
//                       controller: _codeController,
//                     ),
//                   ],
//                 ),
//                 actions: <Widget>[
//                   FlatButton(
//                     child: Text("Confirm"),
//                     textColor: Colors.white,
//                     color: Colors.blue,
//                     onPressed: () async {
//                       final code = _codeController.text.trim();
//                       AuthCredential credential = PhoneAuthProvider.credential(
//                           verificationId: verificationId, smsCode: code);

//                       UserCredential result =
//                           await _auth.signInWithCredential(credential);

//                       User user = result.user;

//                       if (user != null) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => HomeScreen(
//                                       user: user,
//                                     )));
//                       } else {
//                         print("Error");
//                       }
//                     },
//                   )
//                 ],
//               );
//             });
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         // Auto-resolution timed out...
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.all(32),
//         child: Form(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 "Login",
//                 style: TextStyle(
//                     color: Colors.lightBlue,
//                     fontSize: 36,
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                         borderSide: BorderSide(color: Colors.grey[200])),
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                         borderSide: BorderSide(color: Colors.grey[300])),
//                     filled: true,
//                     fillColor: Colors.grey[100],
//                     hintText: "Mobile Number"),
//                 controller: _phoneController,
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               Container(
//                 width: double.infinity,
//                 child: FlatButton(
//                   child: Text("LOGIN"),
//                   textColor: Colors.white,
//                   padding: EdgeInsets.all(16),
//                   onPressed: () {
//                     final phone = _phoneController.text.trim();

//                     loginUser(phone, context);
//                   },
//                   color: Colors.blue,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
