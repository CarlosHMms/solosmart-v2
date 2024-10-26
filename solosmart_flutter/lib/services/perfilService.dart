import 'package:http/http.dart' as http;

class Perfilservice{
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<http.Response> getUserProfile(String token) async {
    final url = Uri.parse('$baseUrl/profile');

    try{
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

  Future<http.Response> updateProfileImage(String token, String filePath) async {
    final request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/profileupd'));
    request.files
        .add(await http.MultipartFile.fromPath('profile_image', filePath));
    request.headers['Authorization'] = 'Bearer $token';
    var response = await request.send();
    return await http.Response.fromStream(response);
  }
}