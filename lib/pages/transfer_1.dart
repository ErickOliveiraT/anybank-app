import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../actions/account_action.dart';

class TransferScreen1 extends StatefulWidget {
  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen1> {
  final TextEditingController _agencyController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  bool loading = false;

  final MaskTextInputFormatter _agencyFormatter = MaskTextInputFormatter(
    mask: '###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final MaskTextInputFormatter _accountFormatter = MaskTextInputFormatter(
    mask: '#####-#',
    filter: {"#": RegExp(r'[0-9]')},
  );

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
          padding: const EdgeInsets.all(16),
          child: Column(children: [
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
            const Text("Para quem você quer transferir?",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 10),
            TextFormField(
              controller: _agencyController,
              inputFormatters: [_agencyFormatter],
              decoration: const InputDecoration(
                hintText: '001',
                labelText: 'Agência',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _accountController,
              inputFormatters: [_accountFormatter],
              decoration: const InputDecoration(
                labelText: 'Conta',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                if (loading) return;
                setState(() {
                  loading = true;
                });
                final agency = _agencyFormatter.getUnmaskedText();
                final account = _accountFormatter.getUnmaskedText();
                final accountData = await findAccount(agency, account);
                if (!accountData.success) {
                  _showToast(accountData.message ?? "");
                  setState(() {
                    loading = false;
                  });
                  return;
                }
                setState(() {
                  loading = false;
                });
                if (accountData.success) {
                  Navigator.of(context).pushNamed('/transfer2');
                } else {
                  _showToast(accountData.message ?? "");
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
                      'Próximo',
                      style: TextStyle(
                        color: Color(0xFFFEFEFE),
                      ),
                    ),
            ),
          ]),
        ));
  }

  @override
  void dispose() {
    _agencyController.dispose();
    _accountController.dispose();
    super.dispose();
  }
}
