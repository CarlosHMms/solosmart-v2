import 'dart:convert';
import 'package:http/http.dart' as http;

class PlacaService{
  final String baseUrl = 'http://localhost:8000/api';


  Future<http.Response> cadastrarPlaca(String name, String numeroSerie,  String token) async {
    final url = Uri.parse('$baseUrl/placas');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
          'numero_serie': numeroSerie
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao se conectar com o servidor: $e');
    }
  }

Future<http.Response> listarPlaca(String token)
    async {
    final url = Uri.parse('$baseUrl/placas');

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

Future<http.Response> removerPlaca(String token, int id)
    async {
    final url = Uri.parse('$baseUrl/placas/delete/$id');

    try {
      final response = await http.delete(
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
