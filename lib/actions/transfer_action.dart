import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const String API_URL = 'http://localhost:3000/transfers';

class TransferResponse {
  final bool success;
  final String message;

  TransferResponse({
    required this.success,
    required this.message,
  });
}

Future<TransferResponse> transfer(
    int sourceAccountId, int destAccountId, double value) async {
  const url = '$API_URL/';

  try {
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "source_account_id": sourceAccountId,
          "dest_account_id": destAccountId,
          "amount": value
        }));

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return TransferResponse(
        message: "Transferência realizada com sucesso!",
        success: true,
      );
    } else {
      return TransferResponse(success: false, message: data['message'][0]);
    }
  } catch (error) {
    print('Erro na requisição: $error');
    return TransferResponse(success: false, message: "$error");
  }
}
