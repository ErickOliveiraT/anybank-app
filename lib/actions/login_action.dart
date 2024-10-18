import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountSessionInfo {
  final String token;
  final String user;
  final String account;
  final String lastTransactions;

  // Construtor
  AccountSessionInfo(
      {required this.user,
      required this.account,
      required this.lastTransactions,
      required this.token});
}

class UserSessionInfo {
  final String token;
  final String accounts;
  final String nickname;

  // Construtor
  UserSessionInfo(
      {required this.token, required this.accounts, required this.nickname});
}

Future<bool> userLogin(String cpf, String password) async {
  const url = 'http://localhost:3000/auth/user/login';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'cpf': cpf,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final UserSessionInfo sessionData = UserSessionInfo(
          accounts: jsonEncode(data['accounts']),
          token: data['token'],
          nickname: data['user']['nickname']);
      await saveUserSessionInfo(sessionData);

      print('Login bem-sucedido: ${data['message']}');
      return true;
    } else {
      print('Falha no login: ${response.body}');
      return false;
    }
  } catch (error) {
    print('Erro na requisição: $error');
    return false;
  }
}

Future<bool> accountLogin(String accountId, String password) async {
  const url = 'http://localhost:3000/auth/account/login';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id_public': accountId,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final AccountSessionInfo sessionData = AccountSessionInfo(
        user: jsonEncode(data['user']),
        account: jsonEncode(data['account']),
        lastTransactions: jsonEncode(data['last_transactions']),
        token: data['token'],
      );
      await saveAccountSessionInfo(sessionData);

      print('Login bem-sucedido: ${data['message']}');
      return true;
    } else {
      print('Falha no login: ${response.body}');
      return false;
    }
  } catch (error) {
    print('Erro na requisição: $error');
    return false;
  }
}

Future checkSession(String entity) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(entity == "user" ? 'user_token' : 'account_token')) {
    return false;
  }

  final token =
      prefs.getString(entity == "user" ? 'user_token' : 'account_token');

  if (token == null) {
    return false;
  }

  const url = 'http://localhost:3000/auth/token/validate';
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{'token': token}),
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data['valid'];
  } catch (error) {
    // Tratar erros de conexão ou requisição
    print('Erro na requisição em checkUserSession(): $error');
    return false;
  }
}

Future<void> saveAccountSessionInfo(AccountSessionInfo data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('account_token', data.token);
  await prefs.setString('user', data.user);
  await prefs.setString('account', data.account);
  await prefs.setString('last_transactions', data.lastTransactions);
}

Future<void> saveUserSessionInfo(UserSessionInfo data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('nickname', data.nickname);
  await prefs.setString('user_token', data.token);
  await prefs.setString('accounts', data.accounts);
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('account_token');
}
