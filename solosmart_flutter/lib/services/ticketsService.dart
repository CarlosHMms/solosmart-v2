import 'dart:convert';
import 'package:http/http.dart' as http;

class Ticketsservice {
  final String baseUrl = 'http://localhost:8000/api';

  Future<http.Response> ticket(String token, String email, int status, String assunto, String descricao) async {
    final url = Uri.parse('$baseUrl/ticket');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'email': email,
          'status': status,
          'assunto': assunto,
          'descricao': descricao,
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao se conectar com o servidor: $e');
    }
  }
}