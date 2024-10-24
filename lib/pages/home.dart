import 'package:anybank_app/config/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _getAccountInfo();
  }

  double accountBalance = 0;
  double accountLimit = 0;
  String nickname = "";
  List<dynamic> lastTransactions = [];

  Future<void> _getAccountInfo() async {
    final userData = Provider.of<UserData>(context, listen: false);
    final account = userData.account;
    final user = userData.user;

    setState(() {
      nickname = user['nickname'] ?? "";
      accountBalance = account['balance'] ?? 0;
      accountLimit = account['credit_limit'] ?? 0;
      lastTransactions = userData.lastTransactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131212),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, size: 30, color: Colors.white),
                      const SizedBox(width: 10),
                      Text('Olá, $nickname!',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white)),
                    ],
                  ),
                  const Icon(Icons.notifications_none,
                      size: 30, color: Colors.white)
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
                  child: (Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Seu saldo',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'R\$ ${formatCurrency(accountBalance)}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 26),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Limite da conta: R\$ ${formatCurrency(accountLimit)}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          const Padding(
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
              _buildLastTransactions()
            ],
          )),
    );
  }

  Widget _buildLastTransactions() {
    List<Widget> transactionItems = [];
    for (var i = 0; i < lastTransactions.length; i++) {
      transactionItems.add(_buildTransactionItem(
          i == 0,
          i == lastTransactions.length - 1,
          lastTransactions[i]['description'],
          lastTransactions[i]['amount'],
          lastTransactions[i]['created_at'],
          lastTransactions[i]['type']));
    }
    return Column(children: transactionItems);
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
              Text(
                  type == "debit"
                      ? "- R\$ ${formatCurrency(value)}"
                      : "+ R\$ ${formatCurrency(value)}",
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
              Text(formatDate(date),
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
                    "Extrato", Icons.format_list_bulleted_sharp, "/transfer1"),
                _buildFunctionButton(
                    "Transferir", Icons.send_outlined, "/transfer1"),
                _buildFunctionButton(
                    "Boletos", Icons.account_balance_outlined, "/transfer2"),
                _buildFunctionButton(
                    "Cartões", Icons.credit_card, "/transfer1"),
              ],
            )),
        const SizedBox(height: 20),
        Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Centraliza os botões
              children: [
                _buildFunctionButton(
                    "Crédito", Icons.diamond_outlined, "/transfer1"),
                _buildFunctionButton(
                    "Investir", Icons.trending_up, "/transfer1"),
                _buildFunctionButton(
                    "Segurança", Icons.lock_outline, "/transfer1"),
                _buildFunctionButton("Config", Icons.settings, "/transfer1"),
              ],
            )),
      ],
    );
  }

  Widget _buildFunctionButton(String title, IconData icon, String path) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(path);
        },
        child: Column(children: [
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
        ]));
  }

  String formatCurrency(double value) {
    return value.toStringAsFixed(2).replaceAll(".", ",");
  }

  String formatDate(String isoDate) {
    DateTime parsedDate = DateTime.parse(isoDate);
    DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(parsedDate);
  }
}
