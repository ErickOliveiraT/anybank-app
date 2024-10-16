import 'package:flutter/material.dart';

class AccountSelection extends StatefulWidget {
  @override
  _AccountSelectionState createState() => _AccountSelectionState();
}

class _AccountSelectionState extends State<AccountSelection> {
  int _selectedAccount = 0;
  int qnt_pass_digits = 0;
  List<String> password_buttons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131212),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment:
          //     MainAxisAlignment.center, // Centraliza verticalmente
          children: [
            // Saudação
            const Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centraliza a Row
              children: [
                Icon(Icons.person, size: 30, color: Colors.white),
                SizedBox(width: 10),
                Text('Olá, Gilberto!',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 30),
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
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Centraliza os textos na Column
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Conta Corrente',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Ag: 0001\nCc: 12331-8',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Radio(
                    value: 0,
                    groupValue: _selectedAccount,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedAccount = value!;
                      });
                    },
                    activeColor: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Informe sua senha eletrônica",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centraliza os elementos da senha
              children: [
                _buildPasswordBox(qnt_pass_digits > 0),
                const SizedBox(width: 5),
                _buildPasswordBox(qnt_pass_digits > 1),
                const SizedBox(width: 5),
                _buildPasswordBox(qnt_pass_digits > 2),
                const SizedBox(width: 5),
                _buildPasswordBox(qnt_pass_digits > 3),
                const SizedBox(width: 5),
                _buildPasswordBox(qnt_pass_digits > 4),
                const SizedBox(width: 5),
                _buildPasswordBox(qnt_pass_digits > 5),
              ],
            ),
            const SizedBox(height: 30),
            _buildButtons(),
            const SizedBox(height: 50),
            SizedBox(
                width: 175,
                child: ElevatedButton(
                  onPressed: () {
                    return;
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: const Color(0xFF3C37BB),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      color: Color(0xFFFEFEFE),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordBox(bool isFilled) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF131212),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: Text(
          isFilled ? "*" : "",
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões
          children: [
            _buildPasswordButton("1 ou 4", () {
              if (password_buttons.length >= 6) return;
              password_buttons.add("1.4");
              setState(() {
                qnt_pass_digits = password_buttons.length;
              });
            }),
            const SizedBox(width: 10),
            _buildPasswordButton("2 ou 9", () {
              if (password_buttons.length >= 6) return;
              password_buttons.add("2.9");
              setState(() {
                qnt_pass_digits = password_buttons.length;
              });
            }),
            const SizedBox(width: 10),
            _buildPasswordButton("5 ou 7", () {
              if (password_buttons.length >= 6) return;
              password_buttons.add("5.7");
              setState(() {
                qnt_pass_digits = password_buttons.length;
              });
            }),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões
          children: [
            _buildPasswordButton("0 ou 6", () {
              if (password_buttons.length >= 6) return;
              password_buttons.add("0.6");
              setState(() {
                qnt_pass_digits = password_buttons.length;
              });
            }),
            const SizedBox(width: 10),
            _buildPasswordButton("3 ou 8", () {
              if (password_buttons.length >= 6) return;
              password_buttons.add("3.8");
              setState(() {
                qnt_pass_digits = password_buttons.length;
              });
            }),
            const SizedBox(width: 10),
            _buildPasswordButton("Del", () {
              if (password_buttons.isEmpty) return;
              password_buttons.removeLast();
              setState(() {
                qnt_pass_digits = password_buttons.length;
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        height: 50,
        width: 100,
        decoration: const BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
