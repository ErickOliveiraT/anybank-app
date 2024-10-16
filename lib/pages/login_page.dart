import "package:flutter/material.dart";
import "../actions/login_action.dart";
import "package:mask_text_input_formatter/mask_text_input_formatter.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final MaskTextInputFormatter _cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131212),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo
              const Column(
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 80.0,
                    color: Color(0xFFFEFEFE),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'AnyBank',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFEFEFE),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'DO JEITO QUE VOCÊ QUISER',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFFFEFEFE),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              // Campo CPF
              TextField(
                controller: _cpfController,
                inputFormatters: [_cpfFormatter],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'CPF',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFF3C37BB)))),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16.0),
              // Campo Senha
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Senha do App',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFF3C37BB)))),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 50.0),
              // Botão Entrar
              ElevatedButton(
                onPressed: () {
                  final cpf = _cpfFormatter.getUnmaskedText();
                  final password = _passwordController.text;

                  loginAction(cpf, password);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
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
              const SizedBox(height: 75.0),
              // Link "Esqueci minha senha"
              Center(
                child: TextButton(
                  onPressed: () {
                    // Implementar ação de "Esqueci minha senha" aqui
                  },
                  child: const Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
