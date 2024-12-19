import 'package:flutter/material.dart';

class RedefinirEmailView extends StatefulWidget {
  const RedefinirEmailView({super.key});

  @override
  State<RedefinirEmailView> createState() => _RedefinirEmailViewState();
}

class _RedefinirEmailViewState extends State<RedefinirEmailView> {
  final TextEditingController _emailController = TextEditingController();

  void _enviarRedefinicaoEmail() {
    final email = _emailController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um e-mail válido')),
      );
      return;
    }

    // Aqui, você pode adicionar a lógica de envio de redefinição de e-mail
    print("Solicitação de redefinição enviada para: $email");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F8DE),
        child: Center(
          child: Container(
            width: 620,
            height: 674,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F8DE),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(-7, 11),
                  blurRadius: 25,
                ),
              ],
              borderRadius: BorderRadius.circular(19),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Redefinir E-mail',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Open Sans',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Novo e-mail',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          hintText: 'Insira seu novo e-mail',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _enviarRedefinicaoEmail,
                  child: Container(
                    width: 472,
                    height: 73,
                    decoration: BoxDecoration(
                      color: const Color(0xFF41337A),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        'Alterar',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Open Sans',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
