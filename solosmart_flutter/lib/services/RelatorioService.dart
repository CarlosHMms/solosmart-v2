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

  Future<List<dynamic>> fetchGravacoesByDate(
      String startDate, String endDate, String token) async {
    final url = Uri.parse('$baseUrl/filtrar');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'initialDate': startDate,
          'finalDate': endDate,
        }),
      );

      if (response.statusCode == 200) {
        // Decodifica os dados da resposta JSON
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Verifica se a resposta tem status 200 e a chave "data" é uma lista
        if (jsonResponse['status'] == 200 && jsonResponse['data'] is List) {
          return jsonResponse['data'] as List<dynamic>;
        } else {
          throw Exception(
              'Formato inesperado na resposta: ${jsonResponse['message']}');
        }
      } else {
        throw Exception(
            'Erro ao buscar dados: Código ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro ao se conectar com o servidor: $e');
    }
  }
}
