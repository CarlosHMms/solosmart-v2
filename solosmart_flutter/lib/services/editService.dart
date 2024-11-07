import 'dart:convert';
import 'package:http/http.dart' as http;

class EditService {
  final String baseUrl = 'http://localhost:8000/api';

  Future<http.Response> edit(
      int id, String token, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/usuarios/perfil/$id');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao se conectar com o servidor: $e');
    }
  }
}
