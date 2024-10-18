import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SessionInfo {
  final String token;
  final String user;
  final String account;
  final String lastTransactions;

  // Construtor
  SessionInfo(
      {required this.user,
      required this.account,
      required this.lastTransactions,
      required this.token});
}

Future<void> userLogin(String cpf, String password) async {
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

    // Verifica se a resposta foi bem-sucedida (status code 200)
    if (response.statusCode == 200) {
      // Converte a resposta JSON para um Map
      final Map<String, dynamic> data = jsonDecode(response.body);
      await saveNicknameAndToken(data['user']['nickname'], data['token']);

      // Exibe a mensagem de sucesso
      print('Login bem-sucedido: ${data['message']}');

      // Lógica adicional se o login for bem-sucedido
    } else {
      // Caso o status code não seja 200, exibe a mensagem de erro
      print('Falha no login: ${response.body}');
    }
  } catch (error) {
    // Tratar erros de conexão ou requisição
    print('Erro na requisição: $error');
  }
}

Future<void> accountLogin(String accountId, String password) async {
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

    // Verifica se a resposta foi bem-sucedida (status code 200)
    if (response.statusCode == 200) {
      // Converte a resposta JSON para um Map
      final Map<String, dynamic> data = jsonDecode(response.body);
      final SessionInfo sessionData = SessionInfo(
        user: jsonEncode(data['user']),
        account: jsonEncode(data['account']),
        lastTransactions: jsonEncode(data['last_transactions']),
        token: data['token'],
      );
      await saveSessionInfo(sessionData);

      // Exibe a mensagem de sucesso
      print('Login bem-sucedido: ${data['message']}');

      // Lógica adicional se o login for bem-sucedido
    } else {
      // Caso o status code não seja 200, exibe a mensagem de erro
      print('Falha no login: ${response.body}');
    }
  } catch (error) {
    // Tratar erros de conexão ou requisição
    print('Erro na requisição: $error');
  }
}

Future<void> saveSessionInfo(SessionInfo data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('account_token', data.token);
  await prefs.setString('user', data.user);
  await prefs.setString('account', data.account);
  await prefs.setString('last_transactions', data.lastTransactions);
}

Future<void> saveNicknameAndToken(String nickname, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('nickname', nickname);
  await prefs.setString('user_token', token);
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('account_token');
}
