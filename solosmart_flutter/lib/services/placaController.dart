
import 'dart:convert';
import 'package:http/http.dart' as http;

class PlacaService{
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<http.Response> cadastrarPlaca(String numeroSerie, int userId) async {
    final url = Uri.parse('$baseUrl/placas');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer seu-token-aqui', // Substitua pelo token de autenticação correto
        },
        body: jsonEncode({
          'numero_serie': numeroSerie,
          'user_id': userId,
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao se conectar com o servidor: $e');
    }
  }
}