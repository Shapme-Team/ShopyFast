import 'package:ShopyFast/domain/provider/authprovider.dart';
import 'package:ShopyFast/getit.dart';
import 'package:ShopyFast/view/components/circularLoadingWidget.dart';
import 'package:ShopyFast/view/screens/Auth/googleButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController _phoneNumberController;

  AuthProvider _authProvider;
  TextEditingController _smsCodeController = TextEditingController();

  String _errorText = '';
  final decorationStyle = TextStyle(color: Colors.black87, fontSize: 16.0);
  bool _codeTimedOut = false;

  @override
  void initState() {
    _authProvider = getIt<AuthProvider>();
    _phoneNumberController = TextEditingController();
    _smsCodeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  onGoogleButtonPressed() {
    _authProvider.onGoogleSigning();
  }

  onSendOTPButtonPressed() {
    var phoneNo = _phoneNumberController.text;
    if (phoneNo.isNotEmpty && phoneNo.length == 10) {
      setState(() => _errorText = '');
      _authProvider.verifyPhoneNumber(_phoneNumberController.text);
      FocusScope.of(context).unfocus();
    } else
      setState(() => _errorText = 'Phone no must be of 10 digit');
  }

  showScaffoldFunction(String message) {
    print('scaffold with: $message');
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  onSmsVerificationButtonPressed() {
    var smsText = _smsCodeController.text;
    if (smsText.isNotEmpty && smsText.length == 6) {
      setState(() => _errorText = '');
      _authProvider.verifyUserOtp(smsText);
      FocusScope.of(context).unfocus();
    } else
      setState(() => _errorText = 'OTP must be of 6 digit');
  }

//-------------------------------------- main widget ------------
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        var authStatus = value.getAuthState;
        var isLoading = value.isLoading;
        var errorMessage = value.getAuthError;

        return Scaffold(
          appBar: AppBar(
              elevation: 1,
              title: Text('Add your profile',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ))),
          body: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildAuthWidgets(authStatus),
                isLoading ? CircularLoadingWidget() : SizedBox(),
                errorMessage != null && errorMessage.length > 0
                    ? buildErrorWidget(errorMessage)
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
//-------------------------------------- main widget ------------------ X

  buildErrorWidget(String message) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).errorColor,
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        'Error: $message',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget buildAuthWidgets(AuthStatusValue authStatus) => Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              authStatus == AuthStatusValue.SOCIAL_AUTH
                  ? GoogleSignInButton(
                      onPressed: onGoogleButtonPressed,
                    )
                  : SizedBox(),
              authStatus == AuthStatusValue.PHONE_AUTH
                  ? _buildPhoneNumberInput(authStatus)
                  : SizedBox(),
              authStatus == AuthStatusValue.SMS_AUTH
                  ? _buildSmsAuthBody()
                  : SizedBox()
            ],
          ),
        ),
      );

  Widget _buildPhoneNumberInput(AuthStatusValue authStatus) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextFormField(
            maxLength: 10,
            controller: _phoneNumberController,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 22.0, color: Colors.black87),
            decoration: InputDecoration(
              isDense: false,
              prefixIcon: const Icon(
                Icons.phone,
                color: Colors.black87,
              ),
              labelText: "Phone no",
              labelStyle: TextStyle(color: Colors.black87, fontSize: 16.0),
              hintText: "Enter your phone no",
              hintStyle: TextStyle(color: Colors.black38),
              errorText: _errorText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () => onSendOTPButtonPressed(),
              child: Text(
                'Send OTP',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSmsAuthBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          child: Text(
            "Verification code",
            style: decorationStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildSmsCodeInput(),
              _buildConfirmInputButton()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _buildResendSmsWidget(),
        )
      ],
    );
  }

  Widget _buildConfirmInputButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: () => onSmsVerificationButtonPressed(),
        child: Text('Verify OTP'),
      ),
    );
  }

  Widget _buildResendSmsWidget() {
    return InkWell(
      onTap: () async {
        if (_codeTimedOut) {
          await onSendOTPButtonPressed();
        } else {
          // _showErrorSnackbar("You can't retry yet!");
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "If your code does not arrive in 1 minute, click",
            style: decorationStyle,
            children: <TextSpan>[
              TextSpan(
                text: " here",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmsCodeInput() {
    return TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      controller: _smsCodeController,
      maxLength: 6,
      onSubmitted: (text) => onSmsVerificationButtonPressed(),
      style: TextStyle(
        fontSize: 32.0,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: "- - - - - -",
        errorText: _errorText,
        // hintStyle: hintStyle.copyWith(fontSize: 42.0),
      ),
    );
  }
}
