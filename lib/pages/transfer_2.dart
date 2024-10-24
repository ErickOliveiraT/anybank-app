import 'package:anybank_app/config/provider.dart';
import 'package:provider/provider.dart';
import '../actions/transfer_action.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class TransferScreen2 extends StatefulWidget {
  @override
  _TransferScreen2State createState() => _TransferScreen2State();
}

class _TransferScreen2State extends State<TransferScreen2> {
  @override
  void initState() {
    super.initState();
    _getDestAccountInfo();
  }

  final TextEditingController _valueController = TextEditingController();

  String holderName = "";
  String holderDoc = "";
  String accountBranch = "";
  String accountNumber = "";
  String accountType = "";
  int destAccountId = -1;
  int sourceAccountId = -1;
  bool loading = false;

  Future<void> _getDestAccountInfo() async {
    final data = Provider.of<UserData>(context, listen: false);
    final destAccount = data.destinationAccount;
    final account = data.account;
    setState(() {
      accountType = destAccount.type;
      accountBranch = destAccount.agency;
      accountNumber = destAccount.number;
      destAccountId = destAccount.id;
      holderName = destAccount.holderName;
      holderDoc = destAccount.holderDoc;
      sourceAccountId = account["id"];
    });
  }

  void _showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // Posição do toast
        timeInSecForIosWeb: 1, // Tempo que ficará visível no iOS
        backgroundColor: Colors.red, // Cor de fundo
        textColor: Colors.white, // Cor do texto
        fontSize: 16.0 // Tamanho da fonte
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131212),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back,
                      size: 30, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Você está transferindo para:",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.all(10.0),
              height: 100,
              width: double.infinity, // Usa todo o espaço disponível
              decoration: BoxDecoration(
                color: const Color(0xFF131212),
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Espaçamento entre itens
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Centraliza os textos na Column
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$holderName  |  ${hideCPF(holderDoc)}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          accountType == "checkings"
                              ? 'Ag: $accountBranch\nCc: $accountNumber'
                              : 'Ag: $accountBranch\nCp: $accountNumber',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Informe o valor",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            TextFormField(
                controller: _valueController,
                inputFormatters: [
                  CurrencyInputFormatter(
                      leadingSymbol: 'R\$ ',
                      thousandSeparator: ThousandSeparator.Period,
                      mantissaLength: 2),
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  //hintText: "R\$ 0,00",
                  labelText: 'Valor (R\$)',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (loading) return;
                setState(() {
                  loading = true;
                });
                final value = double.parse(_valueController.text
                        .replaceAll(RegExp(r'[^\d]'), '')) /
                    100;
                final tranferRes =
                    await transfer(sourceAccountId, destAccountId, value);
                if (!tranferRes.success) {
                  _showToast(tranferRes.message);
                  setState(() {
                    loading = false;
                  });
                  return;
                }
                setState(() {
                  loading = false;
                });
                _showToast(tranferRes.message);
                if (tranferRes.success) {
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: const Color(0xFF3C37BB),
              ),
              child: loading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFFFEFEFE)),
                        strokeWidth: 2.0,
                      ))
                  : const Text(
                      'Transferir',
                      style: TextStyle(
                        color: Color(0xFFFEFEFE),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String hideCPF(String cpf) {
    final cpfDigits = cpf.split('');
    if (cpfDigits.length != 11) return cpf;
    return "${cpfDigits[0]}${cpfDigits[1]}${cpfDigits[2]}.***.***-${cpfDigits[9]}${cpfDigits[10]}";
  }
}
