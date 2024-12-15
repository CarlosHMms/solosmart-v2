import 'dart:convert';
import 'package:http/http.dart' as http;

class RelatorioService {
  final String baseUrl = 'http://localhost:8000/api';

  Future<List<dynamic>> index(String token) async {
    final url = Uri.parse('$baseUrl/gravacoes');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Erro ao carregar dados: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar gravações: $e');
    }
  }
}
