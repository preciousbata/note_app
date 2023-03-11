import 'package:flutter/material.dart';

const kIconButtonSplashRadius = 30.0;
const primaryColor = Color(0xFFFF7643);
const animationDuration = Duration(seconds: 1);

//form errors
final RegExp emailValidator =
    RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
const String emailNull = 'Please enter your email';
const String passwordNull = 'Please enter your password';
const String passwordTooShort = 'invalid password';
const String passwordMatchError = 'invalid password';
const String invalidEmail = 'Invalid Email';
const String titleEmpty = 'Title cannot be empty';

final colors = [
  '000000',
  '9F2B68',
  'BF40BF',
  '00FF00',
  '454B1B',
];
