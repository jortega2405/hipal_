import 'package:flutter/foundation.dart';
import '../services/login_service.dart';
import 'auth_provider.dart';

class LoginProvider extends ChangeNotifier {
  final LoginService _loginService = LoginService();
  final AuthProvider _authProvider;

  String _error = '';

  String get error => _error;

  LoginProvider(this._authProvider);

  Future<bool> login(String email, String password) async {
    try {
      final token = await _loginService.login(email, password);
      // ignore: unnecessary_null_comparison
      if (token != null) {
        await _authProvider.setToken(token);
        return true; // Login exitoso
      } else {
        _error = 'Error de inicio de sesión';
        notifyListeners();
        return false; // Login fallido
      }
    } catch (error) {
      _error = error.toString();
      notifyListeners();
      return false; // Login fallido
    }
  }
}
