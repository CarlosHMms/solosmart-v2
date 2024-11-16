import 'dart:convert';
import 'package:http/http.dart' as http;

class AlertaService {
  final String baseUrl = 'http://localhost:8000/api';

  Future<http.Response> configAlerta(int placaId, String token) async {
    final url = Uri.parse('$baseUrl/config');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'placa_id': placaId,
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao se conectar com o servidor: $e');
    }
  }

  Future<http.Response> listarAlertas(int placaId, String token) async {
    final url = Uri.parse('$baseUrl/alertas/$placaId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao se conectar com o servidor: $e');
    }
  }


}
