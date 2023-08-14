
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _loggedInUser;
  String? _token;

  String? get loggedInUser => _loggedInUser;
  String? get token => _token;

  Future<void> setLoggedInUser(String token) async {
    _loggedInUser = token;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'token', token); // Almacenamos el token en sharedPreferences
  }

  Future<void> setToken(String token) async {
    _token = token;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> loadSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('token');
    if (userJson != null) {
      final userMap = userJson; // Decodificar cadena JSON a mapa
      _loggedInUser = userMap;
      notifyListeners();
    }

    final token = prefs.getString('token');
    if (token != null) {
      _token = token;
      notifyListeners();
    }
  }

  Future<void> logout() async {
  _loggedInUser = null;
  _token = null;

  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');
  await prefs.remove('token');

  notifyListeners();
}
}
