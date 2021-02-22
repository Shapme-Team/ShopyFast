// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import '../../../domain/provider/authprovider.dart';

// import 'googleButton.dart';
// import 'logger.dart';
// import 'reactiverefresh.dart';

// class AuthScreen extends StatefulWidget {
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   static const String TAG = "AUTH";
//   AuthStatusValue status = AuthStatusValue.SOCIAL_AUTH;

//   // Keys
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   // Controllers
//   TextEditingController smsCodeController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();

//   // Variables
//   String _phoneNumber;
//   String _errorMessage;
//   String _verificationId;
//   Timer _codeTimer;

//   bool _isRefreshing = false;
//   bool _codeTimedOut = false;
//   bool _codeVerified = false;
//   Duration _timeOut = const Duration(minutes: 1);

//   // Firebase
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   GoogleSignInAccount _googleUser;
//   User _firebaseUser;

//   // PhoneVerificationFailed
//   verificationFailed(FirebaseAuthException authException) {
//     _showErrorSnackbar(
//         "We couldn't verify your code for now, please try again!");
//     Logger.log(TAG,
//         message:
//             'onVerificationFailed, code: ${authException.code}, message: ${authException.message}');
//   }

//   // PhoneCodeSent
//   codeSent(String verificationId, [int forceResendingToken]) async {
//     Logger.log(TAG,
//         message:
//             "Verification code sent to number ${phoneNumberController.text}");
//     _codeTimer = Timer(_timeOut, () {
//       setState(() {
//         _codeTimedOut = true;
//       });
//     });
//     _updateRefreshing(false);
//     setState(() {
//       this._verificationId = verificationId;
//       this.status = AuthStatusValue.SMS_AUTH;
//       Logger.log(TAG, message: "Changed status to $status");
//     });
//   }

//   // PhoneCodeAutoRetrievalTimeout
//   codeAutoRetrievalTimeout(String verificationId) {
//     Logger.log(TAG, message: "onCodeTimeout");
//     _updateRefreshing(false);
//     setState(() {
//       this._verificationId = verificationId;
//       this._codeTimedOut = true;
//     });
//   }

//   // Styling

//   final decorationStyle = TextStyle(color: Colors.black87, fontSize: 16.0);
//   final hintStyle = TextStyle(color: Colors.black87);

//   //

//   @override
//   void dispose() {
//     _codeTimer?.cancel();
//     super.dispose();
//   }

//   // async

//   Future<Null> _updateRefreshing(bool isRefreshing) async {
//     // Logger.log(TAG,
//     //     message: "Setting _isRefreshing ($_isRefreshing) to $isRefreshing");
//     // if (_isRefreshing) {
//     //   setState(() {
//     //     this._isRefreshing = false;
//     //   });
//     // }
//     setState(() {
//       this._isRefreshing = isRefreshing;
//     });
//   }

//   _showErrorSnackbar(String message) {
//     _updateRefreshing(false);
//     _scaffoldKey.currentState.showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   Future<Null> _signIn() async {
//     var user = _googleSignIn.currentUser;
//     Logger.log(TAG, message: "Just got user as: $user");

//     final onError = (exception, stacktrace) {
//       Logger.log(TAG, message: "Error from _signIn: $exception");
//       _showErrorSnackbar(
//           "Couldn't log in with your Google account, please try again!");
//       user = null;
//     };

//     if (user == null) {
//       user = await _googleSignIn.signIn().catchError(onError);
//       Logger.log(TAG, message: "Received $user");
//       final GoogleSignInAuthentication googleAuth = await user.authentication;
//       Logger.log(TAG, message: "Added googleAuth: $googleAuth");

//       final result = await _auth
//           .signInWithCredential(GoogleAuthProvider.credential(
//             accessToken: googleAuth.accessToken,
//             idToken: googleAuth.idToken,
//           ))
//           .catchError(onError);
//       _firebaseUser = result.user;
//     }

//     if (user != null) {
//       _updateRefreshing(false);
//       _googleUser = user;
//       setState(() {
//         this.status = AuthStatusValue.PHONE_AUTH;
//         Logger.log(TAG, message: "Changed status to $status");
//       });
//       return null;
//     }
//     return null;
//   }

//   Future<Null> _submitPhoneNumber() async {
//     final error = _phoneInputValidator();
//     if (error != null) {
//       _updateRefreshing(false);
//       setState(() {
//         _errorMessage = error;
//       });
//       return null;
//     } else {
//       _updateRefreshing(false);
//       setState(() {
//         _errorMessage = null;
//       });
//       final result = await _verifyPhoneNumber();
//       Logger.log(TAG, message: "Returning $result from _submitPhoneNumber");
//       return result;
//     }
//   }

//   String get phoneNumber {
//     try {
//       _phoneNumber = "+91$_phoneNumber".trim();
//     } catch (error) {
//       Logger.log(TAG,
//           message: "Couldn't access state from _maskedPhoneKey: $error");
//     }
//     return _phoneNumber;
//   }

//   Future<Null> _verifyPhoneNumber() async {
//     Logger.log(TAG, message: "Got phone number as: ${this.phoneNumber}");
//     await _auth.verifyPhoneNumber(
//         phoneNumber: this.phoneNumber,
//         timeout: _timeOut,
//         codeSent: codeSent,
//         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//         verificationCompleted: _linkWithPhoneNumber,
//         verificationFailed: verificationFailed);
//     Logger.log(TAG, message: "Returning null from _verifyPhoneNumber");
//     return null;
//   }

//   Future<Null> _submitSmsCode(String smsText) async {
//     var error;

//     if (smsText.isEmpty) {
//       error = "Your verification code can't be empty!";
//     } else if (smsText.length < 6) {
//       error = "This verification code is invalid!";
//     } else
//       error = null;

//     if (error != null) {
//       _updateRefreshing(false);
//       _showErrorSnackbar(error);
//       return null;
//     } else {
//       if (this._codeVerified) {
//         await _finishSignIn(_auth.currentUser);
//       } else {
//         Logger.log(TAG, message: "_linkWithPhoneNumber called");
//         await _linkWithPhoneNumber(
//           PhoneAuthProvider.credential(
//             smsCode: smsCodeController.text,
//             verificationId: _verificationId,
//           ),
//         );
//       }
//       return null;
//     }
//   }

//   Future<void> _linkWithPhoneNumber(AuthCredential credential) async {
//     final errorMessage = "We couldn't verify your code, please try again!";

//     final result =
//         await _firebaseUser.linkWithCredential(credential).catchError((error) {
//       print("Failed to verify SMS code: $error");
//       _showErrorSnackbar(errorMessage);
//     });
//     _firebaseUser = result.user;

//     await _onCodeVerified(_firebaseUser).then((codeVerified) async {
//       this._codeVerified = codeVerified;
//       Logger.log(
//         TAG,
//         message: "Returning ${this._codeVerified} from _onCodeVerified",
//       );
//       if (this._codeVerified) {
//         await _finishSignIn(_firebaseUser);
//       } else {
//         _showErrorSnackbar(errorMessage);
//       }
//     });
//   }

//   Future<bool> _onCodeVerified(User user) async {
//     final isUserValid = (user != null &&
//         (user.phoneNumber != null && user.phoneNumber.isNotEmpty));
//     if (isUserValid) {
//       setState(() {
//         this.status = AuthStatusValue.PROFILE_AUTH;
//         Logger.log(TAG, message: "Changed status to $status");
//       });
//     } else {
//       _showErrorSnackbar("We couldn't verify your code, please try again!");
//     }
//     return isUserValid;
//   }

//   _finishSignIn(User user) async {
//     await _onCodeVerified(user).then((result) {
//       if (result) {
//         // Here, instead of navigating to another screen, you should do whatever you want
//         // as the user is already verified with Firebase from both
//         // Google and phone number methods
//         // Example: authenticate with your own API, use the data gathered
//         // to post your profile/user, etc.

//         // Navigator.push(
//         //     context,
//         //     MaterialPageRoute(
//         //       builder: (context) => MainScreen(
//         //         googleUser: _googleUser,
//         //         firebaseUser: user,
//         //       ),
//         //     ));
//       } else {
//         setState(() {
//           this.status = AuthStatusValue.SMS_AUTH;
//         });
//         _showErrorSnackbar(
//             "We couldn't create your profile for now, please try again later");
//       }
//     });
//   }

//   // Widgets

//   Widget _buildSocialLoginBody() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           SizedBox(height: 24.0),
//           GoogleSignInButton(
//             onPressed: () => _updateRefreshing(true),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildConfirmInputButton() {
//     final theme = Theme.of(context);
//     return IconButton(
//       icon: Icon(Icons.check),
//       color: theme.accentColor,
//       disabledColor: theme.buttonColor,
//       onPressed: (this.status == AuthStatusValue.PROFILE_AUTH)
//           ? null
//           : () => _updateRefreshing(true),
//     );
//   }

//   Widget _buildPhoneNumberInput() {
//     return TextFormField(
//       maxLength: 10,
//       // key: _maskedPhoneKey,
//       controller: phoneNumberController,
//       keyboardType: TextInputType.number,
//       style: TextStyle(fontSize: 18.0, color: Colors.black87),
//       decoration: InputDecoration(
//         isDense: false,
//         enabled: this.status == AuthStatusValue.PHONE_AUTH,
//         counterText: "",
//         icon: const Icon(
//           Icons.phone,
//           color: Colors.black87,
//         ),
//         labelText: "Phone",
//         labelStyle: TextStyle(color: Colors.black87, fontSize: 16.0),
//         hintText: "enter your phone no",
//         hintStyle: TextStyle(color: Colors.black87),
//         errorText: _errorMessage,
//       ),
//     );
//   }

//   // Widget _buildPhoneNumberInput() {
//   //   return MaskedTextField(
//   //     key: _maskedPhoneKey,
//   //     mask: "(xx) xxxxx-xxxxx",
//   //     keyboardType: TextInputType.number,
//   //     maskedTextFieldController: phoneNumberController,
//   //     maxLength: 15,
//   //     onSubmitted: (text) => _updateRefreshing(true),
//   //     style: Theme.of(context)
//   //         .textTheme
//   //         .subhead
//   //         .copyWith(fontSize: 18.0, color: Colors.black87),
//   //     inputDecoration: InputDecoration(
//   //       isDense: false,
//   //       enabled: this.status == AuthStatusValue.PHONE_AUTH,
//   //       counterText: "",
//   //       icon: const Icon(
//   //         Icons.phone,
//   //         color: Colors.black87,
//   //       ),
//   //       labelText: "Phone",
//   //       labelStyle: decorationStyle,
//   //       hintText: "(99) 99999-9999",
//   //       hintStyle: hintStyle,
//   //       errorText: _errorMessage,
//   //     ),
//   //   );
//   // }

//   Widget _buildPhoneAuthBody() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
//           child: Text(
//             "We'll send an SMS message to verify your identity, please enter your number right below!",
//             style: decorationStyle,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
//           child: Flex(
//             direction: Axis.horizontal,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Flexible(flex: 5, child: _buildPhoneNumberInput()),
//               Flexible(flex: 1, child: _buildConfirmInputButton())
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSmsCodeInput() {
//     final enabled = this.status == AuthStatusValue.SMS_AUTH;
//     return TextField(
//       keyboardType: TextInputType.number,
//       enabled: enabled,
//       textAlign: TextAlign.center,
//       controller: smsCodeController,
//       maxLength: 6,
//       onSubmitted: (text) => _updateRefreshing(true),
//       style: Theme.of(context).textTheme.subhead.copyWith(
//             fontSize: 32.0,
//             color: enabled ? Colors.black87 : Theme.of(context).buttonColor,
//           ),
//       decoration: InputDecoration(
//         counterText: "",
//         enabled: enabled,
//         hintText: "--- ---",
//         hintStyle: hintStyle.copyWith(fontSize: 42.0),
//       ),
//     );
//   }

//   Widget _buildResendSmsWidget() {
//     return InkWell(
//       onTap: () async {
//         if (_codeTimedOut) {
//           await _verifyPhoneNumber();
//         } else {
//           _showErrorSnackbar("You can't retry yet!");
//         }
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: RichText(
//           textAlign: TextAlign.center,
//           text: TextSpan(
//             text: "If your code does not arrive in 1 minute, click",
//             style: decorationStyle,
//             children: <TextSpan>[
//               TextSpan(
//                 text: " here",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSmsAuthBody() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
//           child: Text(
//             "Verification code",
//             style: decorationStyle,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 64.0),
//           child: Flex(
//             direction: Axis.horizontal,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Flexible(flex: 5, child: _buildSmsCodeInput()),
//               Flexible(flex: 2, child: _buildConfirmInputButton())
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: _buildResendSmsWidget(),
//         )
//       ],
//     );
//   }

//   String _phoneInputValidator() {
//     if (phoneNumberController.text.isEmpty) {
//       return "Your phone number can't be empty!";
//     } else if (phoneNumberController.text.length < 14) {
//       return "This phone number is invalid!";
//     }
//     return null;
//   }

//   // String _smsInputValidator() {
//   //   if (smsCodeController.text.isEmpty) {
//   //     return "Your verification code can't be empty!";
//   //   } else if (smsCodeController.text.length < 6) {
//   //     return "This verification code is invalid!";
//   //   }
//   //   return null;
//   // }

//   Widget _buildBody() {
//     Widget body;
//     switch (this.status) {
//       case AuthStatusValue.SOCIAL_AUTH:
//         body = _buildSocialLoginBody();
//         break;
//       case AuthStatusValue.PHONE_AUTH:
//         body = _buildPhoneAuthBody();
//         break;
//       case AuthStatusValue.SMS_AUTH:
//       case AuthStatusValue.PROFILE_AUTH:
//         body = _buildSmsAuthBody();
//         break;
//     }
//     return body;
//   }

//   Future<Null> _onRefresh() async {
//     switch (this.status) {
//       case AuthStatusValue.SOCIAL_AUTH:
//         return await _signIn();
//         break;
//       case AuthStatusValue.PHONE_AUTH:
//         return await _submitPhoneNumber();
//         break;
//       case AuthStatusValue.SMS_AUTH:
//         return await _submitSmsCode(smsCodeController.text);
//         break;
//       case AuthStatusValue.PROFILE_AUTH:
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       // backgroundColor: Colors.black87,
//       body: Container(
//         child: ReactiveRefreshIndicator(
//           onRefresh: _onRefresh,
//           isRefreshing: _isRefreshing,
//           child: Container(child: _buildBody()),
//         ),
//       ),
//     );
//   }
// }
