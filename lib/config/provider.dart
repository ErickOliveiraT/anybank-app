import 'package:flutter/material.dart';
import '../models/destination_account.dart';

class UserData extends ChangeNotifier {
  Map<String, dynamic> _user = {};
  Map<String, dynamic> _account = {};
  List<dynamic> _lastTransactions = [];
  late DestinationAccountData _destinationAccount;

  Map<String, dynamic> get user => _user;
  Map<String, dynamic> get account => _account;
  List<dynamic> get lastTransactions => _lastTransactions;
  DestinationAccountData get destinationAccount => _destinationAccount;

  void setUser(Map<String, dynamic> newUser) {
    _user = newUser;
    notifyListeners();
  }

  void setAccount(Map<String, dynamic> newAccount) {
    _account = newAccount;
    notifyListeners();
  }

  void setLastTransactions(List<dynamic> newLastTransactions) {
    _lastTransactions = newLastTransactions;
    notifyListeners();
  }

  void setDestinationAccount(DestinationAccountData newDestinationAccount) {
    _destinationAccount = newDestinationAccount;
    notifyListeners();
  }
}
