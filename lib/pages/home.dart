import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131212),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, size: 30, color: Colors.white),
                      SizedBox(width: 10),
                      Text('Olá, Gilberto!',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ],
                  ),
                  Icon(Icons.notifications_none, size: 30, color: Colors.white)
                ],
              ),
              const SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF131212),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  width: double.infinity,
                  height: 120,
                  child: (const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Seu saldo',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'R\$ 1423,35',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 26),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Limite da conta: R\$ 500,00',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(Icons.remove_red_eye_outlined,
                                  size: 40, color: Colors.white))
                        ],
                      )))),
              const SizedBox(height: 20),
              const Text("Ações rápidas",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 20),
              _buildButtons(),
              const SizedBox(height: 20),
              const Text("Últimas movimentações",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 20),
              _buildTransactionItem(true, false, "Depósito em conta", 500.45,
                  "18/10/24 12:00", "credit"),
              _buildTransactionItem(false, false, "Pagamento de boleto", 150.45,
                  "17/10/24 13:45", "debit"),
              _buildTransactionItem(false, false, "Pagamento de boleto", 200.65,
                  "17/10/24 13:45", "debit"),
              _buildTransactionItem(false, true, "Transferência recebida",
                  321.21, "16/10/24 13:45", "credit"),
            ],
          )),
    );
  }

  Widget _buildTransactionItem(bool isFirst, bool isLast, String desc,
      double value, String date, String type) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xFF333338),
          borderRadius: isFirst & isLast
              ? const BorderRadius.all(Radius.circular(10))
              : isFirst & !isLast
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))
                  : !isFirst & isLast
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))
                      : BorderRadius.zero,
          border: Border(
              top: isFirst
                  ? BorderSide.none
                  : const BorderSide(
                      width: 1,
                      color: Color(0xFF131212),
                    ),
              bottom: isLast
                  ? BorderSide.none
                  : const BorderSide(
                      width: 1,
                      color: Color(0xFF131212),
                    )),
        ),
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(type == "debit" ? "- R\$ $value" : "+ R\$ $value",
                  style: type == "credit"
                      ? const TextStyle(color: Colors.green, fontSize: 16)
                      : const TextStyle(color: Colors.red, fontSize: 16)),
              Expanded(
                child: Center(
                  child: Text(desc,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              Text(date,
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ));
  }

  Widget _buildButtons() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Centraliza os botões
              children: [
                _buildFunctionButton(
                    "Extrato", Icons.format_list_bulleted_sharp),
                _buildFunctionButton("Transferir", Icons.send_outlined),
                _buildFunctionButton("Boletos", Icons.account_balance_outlined),
                _buildFunctionButton("Cartões", Icons.credit_card),
              ],
            )),
        const SizedBox(height: 20),
        Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Centraliza os botões
              children: [
                _buildFunctionButton("Crédito", Icons.diamond_outlined),
                _buildFunctionButton("Investir", Icons.trending_up),
                _buildFunctionButton("Segurança", Icons.lock_outline),
                _buildFunctionButton("Config", Icons.settings),
              ],
            )),
      ],
    );
  }

  Widget _buildFunctionButton(String title, IconData icon) {
    return Column(children: [
      Container(
        width: 75,
        height: 75,
        decoration: const BoxDecoration(
          color: Color(0xFF333338),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
          ],
        ),
      ),
      const SizedBox(height: 5),
      Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      )
    ]);
  }
}
