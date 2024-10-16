import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> loginAction(String cpf, String password) async {
  const url = 'http://localhost:3000/auth/login';

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
