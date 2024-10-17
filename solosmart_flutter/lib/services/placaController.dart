
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/services/auth_user.dart';
import 'package:solosmart_flutter/utils/provider.dart';

class PlacaService{
  final String baseUrl = 'http://127.0.0.1:8000/api';


  Future<http.Response> cadastrarPlaca(String numeroSerie, int userId, String token) async {
    final url = Uri.parse('$baseUrl/placas');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // Substitua pelo token de autenticação correto
        },
        body: jsonEncode({
          'numero_serie': numeroSerie,
          'users_id': userId,
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao se conectar com o servidor: $e');
    }
  }
}
