import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String API_URL = 'http://localhost:3000/auth';

class LoginResponse {
  final List<dynamic> message;
  final String? error;
  final int statusCode;
  final bool success;
  final Map<String, dynamic>? user;
  final Map<String, dynamic>? account;
  final List<dynamic>? lastTransactions;

  LoginResponse(
      {required this.message,
      required this.error,
      required this.statusCode,
      required this.success,
      this.user,
      this.account,
      this.lastTransactions});
}

class AccountSessionInfo {
  final String token;
  AccountSessionInfo({required this.token});
}

class UserSessionInfo {
  final String token;
  final String accounts;
  final String nickname;

  // Construtor
  UserSessionInfo(
      {required this.token, required this.accounts, required this.nickname});
}

Future<LoginResponse> userLogin(String cpf, String password) async {
  const url = '$API_URL/user/login';

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

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final UserSessionInfo sessionData = UserSessionInfo(
          accounts: jsonEncode(data['accounts']),
          token: data['token'],
          nickname: data['user']['nickname']);
      await saveUserSessionInfo(sessionData);

      return LoginResponse(
        message: data['message'],
        error: data['error'],
        statusCode: data['statusCode'],
        success: true,
      );
    } else {
      return LoginResponse(
          message: jsonDecode(response.body)['message'],
          error: jsonDecode(response.body)['error'],
          statusCode: jsonDecode(response.body)['statusCode'],
          success: false);
    }
  } catch (error) {
    print('Erro na requisição: $error');
    return LoginResponse(
        message: [], error: error.toString(), statusCode: 500, success: false);
  }
}

Future<LoginResponse> accountLogin(
    String accountId, List<String> password) async {
  const url = '$API_URL/account/login';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id_public': accountId,
        'password': jsonEncode(password)
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final AccountSessionInfo sessionData = AccountSessionInfo(
        token: data['token'],
      );

      await saveAccountSessionInfo(sessionData);

      return LoginResponse(
          message: data['message'],
          error: data['error'],
          statusCode: data['statusCode'],
          success: true,
          user: data['user'],
          account: data['account'],
          lastTransactions: data['last_transactions']);
    } else {
      return LoginResponse(
          message: jsonDecode(response.body)['message'],
          error: jsonDecode(response.body)['error'],
          statusCode: jsonDecode(response.body)['statusCode'],
          success: false);
    }
  } catch (error) {
    print('Erro na requisição: $error');
    return LoginResponse(
        message: [], error: error.toString(), statusCode: 500, success: false);
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

  const url = '$API_URL/token/validate';
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
