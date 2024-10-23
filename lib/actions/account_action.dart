import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String API_URL = 'http://localhost:3000/accounts';

class DestinationAccountData {
  final String? agency;
  final String? number;
  final String? holderName;
  final String? holderDoc;
  final String? type;
  final bool success;
  final String? message;
  final int? id;

  DestinationAccountData(
      {this.agency,
      this.number,
      this.holderName,
      this.holderDoc,
      this.type,
      required this.success,
      this.message,
      this.id});
}

Future<DestinationAccountData> findAccount(String agency, String number) async {
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
        id: data['account']['id'],
        success: true,
      );
      await saveDestAccountInfo(destAccount);
      return destAccount;
    } else {
      return DestinationAccountData(
          success: false, message: data['message'][0]);
    }
  } catch (error) {
    print('Erro na requisição: $error');
    return DestinationAccountData(success: false, message: "$error");
  }
}

Future<void> saveDestAccountInfo(DestinationAccountData data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('dest_account_agency', data.agency ?? "");
  await prefs.setString('dest_account_number', data.number ?? "");
  await prefs.setString('dest_account_holder_name', data.holderName ?? "");
  await prefs.setString('dest_account_holder_doc', data.holderDoc ?? "");
  await prefs.setString('dest_account_type', data.type ?? "");
  await prefs.setInt('dest_account_id', data.id ?? 0);
}
