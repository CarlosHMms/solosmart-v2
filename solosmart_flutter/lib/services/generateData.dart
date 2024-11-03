import 'dart:convert';
import 'package:http/http.dart' as http;

class Generatedata{
  final String baseUrl = 'http://127.0.0.1:8000/api';


  Future<http.Response> gerarDados(int placaId,  String token) async {
    final url = Uri.parse('$baseUrl/gerar');

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

  Future<http.Response> buscarDados(int placaId,  String token) async {
    final url = Uri.parse('$baseUrl/buscar/$placaId');

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