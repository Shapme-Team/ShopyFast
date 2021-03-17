import 'package:flutter/material.dart';
import 'size_config.dart';

const kPrimaryColor = Color(0xFFf85717);
const kAccentColor = Color(0xff1f2e4e);
const kActiveGreenColor = Color(0xff29AB87);
// const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = [Color(0xFFFFA53E), Color(0xFFFF7643)];
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const errorColor = Color(0xffff0033);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getHeight(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

ElevatedButtonThemeData kElevatedButtonThemeData = ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) =>
            states.contains(MaterialState.pressed)
                ? kAccentColor.withOpacity(.9)
                : kAccentColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        )));
TextButtonThemeData kTextButtonThemeData = TextButtonThemeData(
    style: ButtonStyle(
        textStyle: MaterialStateProperty.all(TextStyle(color: kAccentColor)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        )));
OutlinedButtonThemeData kOutlinedButtonThemeData = OutlinedButtonThemeData(
    style: ButtonStyle(
        textStyle: MaterialStateProperty.all(TextStyle(color: kAccentColor)),
        side: MaterialStateProperty.all(
            BorderSide(color: kAccentColor, width: 1))));

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: getHeight(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
