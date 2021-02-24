import 'dart:async';

import 'package:ShopyFast/domain/models/customer.dart';
import 'package:ShopyFast/domain/repositories/customerRepository.dart';
import 'package:ShopyFast/utils/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatusValue { SOCIAL_AUTH, PHONE_AUTH, SMS_AUTH, PROFILE_AUTH }
const String ERROR_PHONENO_TEXT =
    'Error while verifying you given Phone number, Try Again !';
const String ERROR_GOOGLE_TEXT =
    'Error while verifying your google account, Try Again !';
const String ERROR_SMS_VERIFICATION_TEXT = 'Failed to verify OTP !';

class AuthProvider extends ChangeNotifier {
  final CustomerRepository _customerRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _googleSignIn = GoogleSignIn();

  bool _isSigningIn;
  bool _isGoogleAuthenticated;
  bool _isPhoneAuthenticated;
  User _firebaseUser;
  bool _isLoading = false;
  Customer _currentCustomer;
//-------------------------------- phone auth variables
  String _verificationId;
  Timer _codeTimer;
  String _authError = '';

  bool _isRefreshing = false;
  bool _codeTimedOut = false;
  bool _isCodeSent = false;
  bool _codeVerified = false;

  Duration _timeOut = const Duration(minutes: 1);

//-------------------------------- phone auth variables X

  AuthProvider(this._customerRepository) {
    // logout();
    _isSigningIn = false;
    _firebaseUser = _auth.currentUser;

    _isGoogleAuthenticated = _firebaseUser != null;
    _isPhoneAuthenticated = _auth.currentUser?.phoneNumber != null;

    print('is google auth : $_isGoogleAuthenticated');
    print('is phone auth : $_isPhoneAuthenticated');
    getCurrentCustomer();
  }

  bool get isSigningIn => _isSigningIn;
  bool get isSignedIn => _isGoogleAuthenticated;
  AuthStatusValue get getAuthState => _getAuthType();
  bool get isCodeSent => _isCodeSent;
  bool get isLoading => _isLoading;
  String get getAuthError => _authError;
  Customer get getCustomer => _currentCustomer;
  User get getCurrentUser => _auth?.currentUser;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future login() async {
    isSigningIn = true;

    final user = await _googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      isSigningIn = false;
    }
  }

  onGoogleSigning() async {
    _setLoading(true);
    try {
      var currentAccount = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await currentAccount.authentication;

      final result =
          await _auth.signInWithCredential(GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ));
      _firebaseUser = result.user;
      if (_firebaseUser.phoneNumber != null) {
        fetchAlreadyExistUser(_firebaseUser.uid);
      }
    } catch (err) {
      print(err);
      _authError = ERROR_GOOGLE_TEXT;
    }
    _setLoading(false);
  }

  verifyPhoneNumber(String phoneNo) async {
    // Logger.log(TAG, message: "Got phone number as: ${this.phoneNumber}");
    _setLoading(true);
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNo',
      timeout: _timeOut,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      verificationCompleted: _linkWithPhoneNumber,
      verificationFailed: onVerificationFailed,
    );
  }

  Future<void> _linkWithPhoneNumber(AuthCredential credential) async {
    _setLoading(true);
    try {
      final result = await _firebaseUser.linkWithCredential(credential);
      _firebaseUser = result.user;
      var codeVerified = await checkPhoneNoAuthenticated(_firebaseUser);

      _codeVerified = codeVerified;
      if (_codeVerified) {
        _isCodeSent = false;
      } else {
        throw 'Phone number not verified';
      }
    } catch (err) {
      _authError = ERROR_SMS_VERIFICATION_TEXT;
      print("Failed to verify SMS code: $err with : $_authError");
    } finally {
      _setLoading(false);
    }
  }

  verifyUserOtp(String smsText) {
    var credentials = PhoneAuthProvider.credential(
      smsCode: smsText,
      verificationId: _verificationId,
    );
    _linkWithPhoneNumber(credentials);
  }

  onVerificationFailed(Exception firebaseException) {
    print('on verification failed with ex : $firebaseException');
    _authError = ERROR_PHONENO_TEXT;
    notifyListeners();
  }

  Future<bool> checkPhoneNoAuthenticated(User user) async {
    final isUserValid = (user != null &&
        (user.phoneNumber != null && user.phoneNumber.isNotEmpty));
    if (isUserValid) {
      print('phone no; ${_firebaseUser.phoneNumber}');
      print(
          'phone no after short ${_firebaseUser.phoneNumber.replaceRange(0, 3, "")}');
      var customer = Customer(
        address: '',
        customerId: _firebaseUser.uid,
        email: _firebaseUser.email,
        name: _firebaseUser.displayName,
        phoneNumber:
            int.parse(_firebaseUser.phoneNumber.replaceRange(0, 3, "")),
      );
      await saveCurrentCustomer(customer);
      // notify status
    } else {
      print("We couldn't verify your code, please try again!");
    }
    return isUserValid;
  }

  codeAutoRetrievalTimeout(String verificationId) {
    _verificationId = verificationId;
    _codeTimedOut = true;

    // notify
    notifyListeners();
  }

  codeSent(String verificationId, [int forceResendingToken]) async {
    _setLoading(false);
    print("Verification code sent to number");
    // _updateRefreshing(false);
    _verificationId = verificationId;
    _isCodeSent = true;
    notifyListeners();
  }

//------------------------------------------------------- small functions ;

  void logout() async {
    await FirebaseAuth.instance.signOut();
    _firebaseUser = null;
    _customerRepository.deleteCustomerLocally();
    notifyListeners();
  }

  AuthStatusValue _getAuthType() {
    var authStatus;
    bool isGoogleAuth = _firebaseUser != null;
    bool isPhoneAuth = _firebaseUser?.phoneNumber != null;

    if (isGoogleAuth) {
      authStatus = AuthStatusValue.PHONE_AUTH;
    } else
      authStatus = AuthStatusValue.SOCIAL_AUTH;

    if (isGoogleAuth && isPhoneAuth) {
      authStatus = AuthStatusValue.PROFILE_AUTH;

      // logout();
    }
    if (isCodeSent) {
      authStatus = AuthStatusValue.SMS_AUTH;
    }

    return authStatus;
  }

//------------------------------------ customer ------------------
  getCurrentCustomer() async {
    if (_currentCustomer != null) return;
    var customer =
        await _customerRepository.getCustomerData(_firebaseUser?.uid);
    if (customer != null) {
      _currentCustomer = customer;
      globalCustomerData = customer;
      notifyListeners();
    } else {
      specialCaseCustomerGet();
    }
    // logout();
  }

  fetchAlreadyExistUser(String uid) async {
    print('------ already exist fetch');
    var customer = await _customerRepository.getCustomerData(uid);
    if (customer != null) {
      print('customerId: ${customer.customerId}');
      await saveCurrentCustomer(customer, true);
      _currentCustomer = customer;
      notifyListeners();
    } else {
      print('customer not found in database');
      customer = Customer(
        address: '',
        customerId: _firebaseUser.uid,
        email: _firebaseUser.email,
        name: _firebaseUser.displayName,
        phoneNumber: int.parse(_firebaseUser.phoneNumber),
      );
      saveCurrentCustomer(customer);
    }
  }

  specialCaseCustomerGet() async {
    if (_getAuthType() == AuthStatusValue.PROFILE_AUTH &&
        _currentCustomer == null) {
      print('customer is null, but authenticated calling special case');

      var customer = Customer(
        address: '',
        customerId: _firebaseUser.uid,
        email: _firebaseUser.email,
        name: _firebaseUser.displayName,
        phoneNumber: int.parse(_firebaseUser.phoneNumber),
      );
      await saveCurrentCustomer(customer);
    }
  }

  saveCurrentCustomer(Customer customer, [bool isLocal]) async {
    var responce = await _customerRepository.addCustomerData(customer, isLocal);
    if (responce == true) {
      _currentCustomer = customer;
    }
    notifyListeners();
  }

  updateCurrentCustomer(Customer customer) async {
    var responce = await _customerRepository.updateCustomer(customer);
    if (responce == true) {
      _currentCustomer = customer;
    }
    notifyListeners();
  }

//------------------------------------ customer ------------------ X

  _setLoading(bool status) {
    _isLoading = status;
    if (status) _authError = '';
    notifyListeners();
  }
}
