import 'dart:convert';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:solosmart_flutter/services/ImageService.dart';
import 'package:solosmart_flutter/services/generateData.dart';
import 'package:solosmart_flutter/services/perfilService.dart';

// Provider para gerenciar o estado do token
class AllProvider with ChangeNotifier {
  String? _token;
  String? _name;
  String? _email;
  String? _password;
  int? _userId;
  Map<String, dynamic>? _user;
  Map<String, dynamic>? _placas;
  Map<String, dynamic>? _dados;
  Map<String, dynamic>? _profile;
  Map<String, dynamic>? _configs;
  Map<String, dynamic>? _alertas;
  int? _placaId;

  int? get userId => _userId;

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }

  String? get name => _name;

  void setName(String name){
    _name = name;
    notifyListeners();
  }

  String? get email => _email;

  void setEmail(String email){
    _email = email;
    notifyListeners();
  }

  String? get password => _password;

  void setPassword(String password){
    _password = password;
    notifyListeners();
  }

  int? get placaId => _placaId;

  void setPlacaId(int placaId) {
    _placaId = placaId;
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

  Map<String, dynamic>? get configs => _configs;

  void setConfigs(Map<String, dynamic> configs) {
    _configs = configs;
    notifyListeners();
  }

  Map<String, dynamic>? get alertas => _alertas;

  void setAlertas(Map<String, dynamic> alertas) {
    _alertas = alertas;
    notifyListeners();
  }

  Future<void> atualizarDados(int placaId) async {
    if (_token == null) return;

    final generateDataService = Generatedata();

    try {
      final response = await generateDataService.gerarDados(placaId, _token!);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        Map<String, dynamic>? novoDados = responseData['data']?['gravacao'];
        Map<String, dynamic>? alertas = responseData['data']?['alerta'];
        if (dados != null) {
          setDados(novoDados!);
        }
        if (alertas != null) {
          setAlertas(alertas);
        }
      } else {
        print('Erro ao gerar dados: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao se conectar com o servidor: $e');
    }
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


