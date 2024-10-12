import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:solosmart_flutter/services/recoveryPassword.dart';
import 'package:solosmart_flutter/views/login_view.dart';

class PasswordRecoveryView extends StatefulWidget {
  const PasswordRecoveryView({super.key});

  @override
  State<PasswordRecoveryView> createState() => _PasswordRecoveryViewState();
}

class _PasswordRecoveryViewState extends State<PasswordRecoveryView> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService(); // Instância do AuthService

  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6D4C3D), // Fundo marrom
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: 350, // Largura do container
          decoration: BoxDecoration(
            color: const Color(0xFFF5F8DE), // Cor Off-White do container
            borderRadius: BorderRadius.circular(10.0), // Bordas arredondadas
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3), // Sombra
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/SoloSmart.png', // Caminho da imagem
                  width: 200, // Largura da imagem
                  height: 100, // Altura da imagem
                ),
                const Text(
                  'Recuperar Senha',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Cor do texto título
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onSaved: (value) => _email = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu email';
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      try {
                        final message = await _authService.passwordRecovery(
                            _email); // Chama a função de recuperação de senha

                        // Exibe mensagem dependendo do resultado
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            backgroundColor:
                                Colors.green, // Cor verde para sucesso
                          ),
                        );

                        // Verifica se a recuperação foi bem-sucedida
                        if (message.startsWith('Sucesso')) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()),
                          );
                        }
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Erro ao conectar-se ao servidor: $e'),
                            backgroundColor:
                                Colors.red, // Cor vermelha para erro
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF41337A), // Cor do botão
                    padding: const EdgeInsets.symmetric(
                      horizontal: 115,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Define a borda
                    ),
                  ),
                  child: const Text(
                    'Enviar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Cor do texto do botão
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Lembrou a senha?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()),
                        );
                      },
                      child: const Text(
                        'Faça login',
                        style: TextStyle(color: Colors.blue), // Cor do link
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
