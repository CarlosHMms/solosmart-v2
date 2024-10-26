import 'package:http/http.dart' as http;

class ImageService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<http.Response> getUserImage(String token, String filename) async {
    final url =
        Uri.parse('$baseUrl/$filename');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception('Erro ao se conectar com o servidor: $e');
    }
  }
}
