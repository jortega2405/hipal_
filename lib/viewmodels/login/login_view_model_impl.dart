import 'package:flutter/material.dart';
import 'package:hipal/providers/login_provider.dart';
import 'package:hipal/providers/auth_provider.dart';
import 'package:hipal/viewmodels/login/login_view_model.dart';

class LoginViewModelImpl extends LoginViewModel {
  final LoginProvider _loginProvider;
  final AuthProvider _authProvider;

  String _email = '';
  String _password = '';

  String _emailError = '';
  String _passwordError = '';

  LoginViewModelImpl(this._loginProvider, this._authProvider);

  @override
  void updateEmail(String value) {
    _email = value;
    validateEmail(value);
    notifyListeners();
  }

  @override
  void updatePassword(String value) {
    _password = value;
    validatePassword(value);
    notifyListeners();
  }

  @override
  Future<bool> performLogin(BuildContext context) async {
    if (validateFields()) {
      final result = await _loginProvider.login(_email, _password);

      if (result) {
        await _authProvider.loadSavedUser();
        Navigator.pushReplacementNamed(context, '/home');
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  @override
  String get email => _email;

  @override
  String get password => _password;

  @override
  String get emailError => _emailError;

  @override
  String get passwordError => _passwordError;

  bool validateFields() {
    return _emailError.isEmpty && _passwordError.isEmpty;
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      _emailError = 'Ingrese un correo';
    } else if (!isValidEmail(value)) {
      _emailError = 'Correo inválido';
    } else {
      _emailError = '';
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      _passwordError = 'Ingrese una contraseña';
    } else if (value.length < 6) {
      _passwordError = 'La contraseña debe tener al menos 6 caracteres';
    } else if (!isValidPassword(value)) {
      _passwordError = 'La contraseña debe tener entre 6 y 20 caracteres';
    } else {
      _passwordError = '';
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    return emailRegex.hasMatch(email) && email.length <= 50;
  }

  bool isValidPassword(String password) {
    return password.length <= 20;
  }
}
