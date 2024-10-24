import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/destination_account.dart';

// ignore: constant_identifier_names
const String API_URL = 'http://localhost:3000/accounts';

class FindAccountResponse {
  final bool success;
  final String message;
  final DestinationAccountData? account;

  FindAccountResponse({
    required this.success,
    required this.message,
    this.account,
  });
}

Future<FindAccountResponse> findAccount(String agency, String number) async {
  final url = '$API_URL/find?agency=$agency&number=$number';

  try {
    final response = await http.get(Uri.parse(url));

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final destAccount = DestinationAccountData(
          agency: data['account']['agency'],
          number: data['account']['number'],
          holderName: data['user']['name'],
          holderDoc: data['user']['cpf'],
          type: data['account']['type'],
          id: data['account']['id']);
      return FindAccountResponse(
          success: true, message: "Account found!", account: destAccount);
    } else {
      return FindAccountResponse(success: false, message: "Account not found");
    }
  } catch (error) {
    print('Erro na requisição: $error');
    return FindAccountResponse(success: false, message: "$error");
  }
}
