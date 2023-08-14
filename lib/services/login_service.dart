import 'dart:convert';

import 'package:hipal/utils/constants.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<String> login(String email, String pwd) async {
  final url = Uri.parse('${Constants.baseUrl}api/login');
  final body = jsonEncode({
    'email': email,
    'password': pwd,
  });
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['token'];
      return token; // Devuelve el token en caso de éxito
    } else {
      throw 'Error de inicio de sesión'; // Lanza una excepción en caso de que el inicio de sesión falle
    }
  } catch (e) {
    throw 'Error de inicio de sesión, por favor valida tus credenciales';
  }
}
}
