import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  Map<String, dynamic> _user = {};
  Map<String, dynamic> _account = {};
  List<dynamic> _lastTransactions = [];

  Map<String, dynamic> get user => _user;
  Map<String, dynamic> get account => _account;
  List<dynamic> get lastTransactions => _lastTransactions;

  void setUser(Map<String, dynamic> newUser) {
    _user = newUser;
    notifyListeners(); // Notifica a UI que o estado mudou
  }

  void setAccount(Map<String, dynamic> newAccount) {
    _account = newAccount;
    notifyListeners(); // Notifica a UI que o estado mudou
  }

  void setLastTransactions(List<dynamic> newLastTransactions) {
    _lastTransactions = newLastTransactions;
    notifyListeners(); // Notifica a UI que o estado mudou
  }
}
