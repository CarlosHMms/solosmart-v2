import 'package:flutter/material.dart';

// Provider para gerenciar o estado do token
class AllProvider with ChangeNotifier {
  String? _token;
  int? _userId;
  Map<String, dynamic>? _user;
  Map<String, dynamic>? _placas;
  Map<String, dynamic>? _dados;

  int? get userId => _userId;

  void setUserId(int userId){
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

  void setPlacas(Map<String, dynamic> placas){
    _placas = placas;
    notifyListeners();
  }

  Map<String, dynamic>? get dados => _dados;

  void setDados(Map<String, dynamic> dados){
    _dados = dados;
    notifyListeners();
  }
}
