import 'package:http/http.dart' as http;
import 'dart:convert';

class EditPlacaService {
  final String baseUrl = 'http://localhost:8000/api';

  Future<http.Response> editName(String name, String token, int id) async {
    final url = Uri.parse('$baseUrl/placas/edit/$id');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao tentar editar o nome da placa: $e');
    }
  }
}
