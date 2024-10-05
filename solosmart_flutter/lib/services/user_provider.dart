import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic>? _user;

  Map<String, dynamic>? get user => _user;

  void setUser(Map<String, dynamic> userData) {
    _user = userData;
    notifyListeners(); // Notifica todas as telas que estão escutando mudanças
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
