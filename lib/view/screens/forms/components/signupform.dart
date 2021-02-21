import 'package:ShopyFast/utils/constants/constants.dart';
import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:ShopyFast/view/components/custom_surfix_icon.dart';
import 'package:ShopyFast/view/components/default_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ShopyFast/view/components/form_error.dart';
import 'package:ShopyFast/view/screens/bottomNavScreens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final user = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>();
  String name;
  String mobileNo;
  String conform_password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: getHeight(30)),
          buildmobileFormField(),
          SizedBox(height: getHeight(30)),
          buildAdressFormField(),
          FormError(errors: errors),
          SizedBox(height: getHeight(40)),
          DefaultButton(
            text: "Save",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                Navigator.pushNamed(context, ProfileScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildmobileFormField() {
    return TextFormField(
      initialValue: user.phoneNumber,
      onSaved: (newValue) => mobileNo = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        } else if (value.length != 10) {
          removeError(error: kPhoneNumberNullError);
        }
        mobileNo = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        } else if (value.length != 10) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Mobile Number",
        hintText: "Enter your Mobile Number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      initialValue: user.displayName,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //  suffixIcon: Icon(Icons.person),
      ),
    );
  }

  TextFormField buildAdressFormField() {
    return TextFormField(
      initialValue: 'Rohine Sector 13',
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: Icon(Icons.person),
      ),
    );
  }
}
