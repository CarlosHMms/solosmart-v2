import 'dart:convert';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:solosmart_flutter/services/ImageService.dart';
import 'package:solosmart_flutter/services/perfilService.dart';
import 'package:http/http.dart' as http;

// Provider para gerenciar o estado do token
class AllProvider with ChangeNotifier {
  String? _token;
  int? _userId;
  Map<String, dynamic>? _user;
  Map<String, dynamic>? _placas;
  Map<String, dynamic>? _dados;
  Map<String, dynamic>? _profile;

  int? get userId => _userId;

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }

  String? get token => _token;

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  Map<String, dynamic>? get user => _user;

  void setUser(Map<String, dynamic> user) {
    _user = user;
    notifyListeners();
  }

  Map<String, dynamic>? get placas => _placas;

  void setPlacas(Map<String, dynamic> placas) {
    _placas = placas;
    notifyListeners();
  }

  Map<String, dynamic>? get dados => _dados;

  void setDados(Map<String, dynamic> dados) {
    _dados = dados;
    notifyListeners();
  }

  Future<void> fetchUserProfile() async {
    if (_token == null) return;

    final perfilService = Perfilservice();
    try {
      final response = await perfilService.getUserProfile(_token!);
      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        _profile = jsonDecode(response.body);
        notifyListeners();
      } else {
        throw Exception('Falha ao carregar perfil do usuário');
      }
    } catch (e) {
      print("Erro ao buscar perfil: $e");
      // Trate o erro conforme necessário
    }
  }
}

class ProfileImageProvider with ChangeNotifier {
  Uint8List? _imageBytes;

  Uint8List? get imageBytes => _imageBytes;

  // Constructor modificado para receber o contexto
  ProfileImageProvider(BuildContext context) {
    loadImageBytes(context); // Chama o método de carregar a imagem
  }

  // Método para carregar os bytes da imagem de perfil a partir da URL no 'user'
  Future<void> loadImageBytes(BuildContext context) async {
    // Acessa o AllProvider para obter o 'user'
    final allProvider = Provider.of<AllProvider>(context, listen: false);
    final userProfile = allProvider.user; // Obtém os dados do usuário
    final imageUrl = userProfile?['profile_image']; // Pega a URL da imagem
    final token = allProvider.token; // Obtém o token de autenticação

    // Verifica se a URL da imagem não é nula ou vazia
    if (imageUrl != null && imageUrl.isNotEmpty) {
      // Extrai o nome do arquivo
      final filename = imageUrl.split('profiles/').last;

      try {
        // Usa o ImageService para obter a imagem
        final imageService = ImageService();
        final response = await imageService.getUserImage(token!, filename);

        if (response.statusCode == 200) {
          _imageBytes = response.bodyBytes; // Armazena os bytes da imagem
          notifyListeners(); // Notifica que a imagem foi carregada
        } else {
          print('Erro ao carregar a imagem do perfil: ${response.statusCode}');
        }
      } catch (e) {
        print('Erro ao carregar a imagem: $e');
      }
    } else {
      print('URL da imagem de perfil é nula ou vazia.');
    }
  }

  Future<void> setImageBytes(Uint8List? bytes) async {
    _imageBytes = bytes;
    notifyListeners(); // Notifica que a imagem foi alterada
  }
}


