import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://127.0.0.1/api';

  Future<String> passwordRecovery(String email) async {
    final url = Uri.parse('$baseUrl/recover');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['status'];
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        return errorData['email'][0];
      }
    } catch (e) {
      throw Exception('Erro ao se conectar com o servidor: $e');
    }
  }
}
