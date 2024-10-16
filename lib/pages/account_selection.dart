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
          children: [
            // Saudação
            const Row(
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
                height: 85,
                decoration: BoxDecoration(
                  color: const Color(0xFF131212),
                  border: Border.all(
                    color: Colors.white, // Cor do contorno
                    width: 1, // Espessura da borda
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    const Column(
                      children: [
                        SizedBox(height: 4),
                        Text(
                          '   Conta Corrente',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Ag: 0001\nCc: 12331-8',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(width: 250),
                    Radio(
                      value: 0,
                      groupValue: _selectedAccount,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedAccount = value!;
                        });
                      },
                      activeColor: Colors.white,
                    )
                  ],
                )),
            const SizedBox(height: 10),
            const Text(
              "Informe sua senha eletrônica",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF131212),
                      border: Border.all(
                        color: Colors.white, // Cor do contorno
                        width: 1, // Espessura da borda
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      qnt_pass_digits > 0 ? "*" : "",
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ))),
                const SizedBox(width: 5),
                Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF131212),
                      border: Border.all(
                        color: Colors.white, // Cor do contorno
                        width: 1, // Espessura da borda
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      qnt_pass_digits > 1 ? "*" : "",
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ))),
                const SizedBox(width: 5),
                Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF131212),
                      border: Border.all(
                        color: Colors.white, // Cor do contorno
                        width: 1, // Espessura da borda
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      qnt_pass_digits > 2 ? "*" : "",
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ))),
                const SizedBox(width: 5),
                Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF131212),
                      border: Border.all(
                        color: Colors.white, // Cor do contorno
                        width: 1, // Espessura da borda
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      qnt_pass_digits > 3 ? "*" : "",
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ))),
                const SizedBox(width: 5),
                Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF131212),
                      border: Border.all(
                        color: Colors.white, // Cor do contorno
                        width: 1, // Espessura da borda
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      qnt_pass_digits > 4 ? "*" : "",
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ))),
                const SizedBox(width: 5),
                Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF131212),
                      border: Border.all(
                        color: Colors.white, // Cor do contorno
                        width: 1, // Espessura da borda
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      qnt_pass_digits > 5 ? "*" : "",
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ))),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                Center(
                    child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (password_buttons.length >= 6) return;
                          password_buttons.add("1.4");
                          setState(() {
                            qnt_pass_digits = password_buttons.length;
                          });
                          print(password_buttons);
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 50,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                                child: Text(
                              "1 ou 4",
                              style: TextStyle(color: Colors.white),
                            )))),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          if (password_buttons.length >= 6) return;
                          password_buttons.add("2.9");
                          setState(() {
                            qnt_pass_digits = password_buttons.length;
                          });
                          print(password_buttons);
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 50,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                                child: Text(
                              "2 ou 9",
                              style: TextStyle(color: Colors.white),
                            )))),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          if (password_buttons.length >= 6) return;
                          password_buttons.add("5.7");
                          setState(() {
                            qnt_pass_digits = password_buttons.length;
                          });
                          print(password_buttons);
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 50,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                                child: Text(
                              "5 ou 7",
                              style: TextStyle(color: Colors.white),
                            ))))
                  ],
                )),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (password_buttons.length >= 6) return;
                          password_buttons.add("0.6");
                          setState(() {
                            qnt_pass_digits = password_buttons.length;
                          });
                          print(password_buttons);
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 50,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                                child: Text(
                              "0 ou 6",
                              style: TextStyle(color: Colors.white),
                            )))),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          if (password_buttons.length >= 6) return;
                          password_buttons.add("3.8");
                          setState(() {
                            qnt_pass_digits = password_buttons.length;
                          });
                          print(password_buttons);
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 50,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                                child: Text(
                              "3 ou 8",
                              style: TextStyle(color: Colors.white),
                            )))),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          if (password_buttons.length == 0) return;
                          password_buttons.removeLast();
                          print(password_buttons);
                          setState(() {
                            qnt_pass_digits = password_buttons.length;
                          });
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 50,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                                child: Text(
                              "Del",
                              style: TextStyle(color: Colors.white),
                            ))))
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                return;
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: const Color(0xFF3C37BB)),
              child: const Text(
                'Entrar',
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
}
