import 'package:flutter/material.dart';

abstract class LoginViewModel extends ChangeNotifier {
  void updateEmail(String value);
  void updatePassword(String value);
  Future<bool> performLogin(BuildContext context);

  String get email;
  String get password;
  String get emailError;
  String get passwordError;
}
