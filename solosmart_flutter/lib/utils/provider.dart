import 'package:flutter/material.dart';

// Provider para gerenciar o estado do token
class AllProvider with ChangeNotifier {
  String? _token;
  int? _userId;

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
}
