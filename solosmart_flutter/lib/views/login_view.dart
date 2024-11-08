import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/utils/provider.dart';
import 'package:solosmart_flutter/views/recuperar_view.dart';
import 'inicio_view.dart';
import 'package:solosmart_flutter/services/auth_user.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService =
      AuthService(); // Criando uma instância do AuthService

  String _email = '';
  String _password = '';

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
                  'Login',
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
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                  onSaved: (value) => _password = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    } else if (value.length < 6) {
                      return 'A senha deve ter no mínimo 6 caracteres';
                    }
                    return null;
                  },
                ),
                Positioned(
                  left: 727,
                  top: 646,
                  child: SizedBox(
                    width: 466,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Redireciona para a página de recuperação de senha
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PasswordRecoveryView(),
                            ),
                          );
                        },
                        child: const Text(
                          'Esqueceu a senha?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'Open Sans',
                            decoration:
                                TextDecoration.underline, // Estilo de link
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    // Alterando para uma função assíncrona
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      // Chamada da função de login
                      try {
                        final response =
                            await _authService.login(_email, _password);
                        if (response.statusCode == 200) {
                          final Map<String, dynamic> responseData = jsonDecode(response.body);
                          print(responseData);
                          String? token = responseData['data']['token'];
                          int? userId = responseData['data']['user']['id'];
                          print(userId);
                          Map<String, dynamic>? user = responseData['data']['user'];
                          String? name = responseData['data']['user']['name'];
                          String? email = responseData['data']['user']['email'];
                          var password = _password;
                          Provider.of<AllProvider>(context, listen: false).setPassword(password);
                          if (email != null){
                            Provider.of<AllProvider>(context, listen: false).setEmail(email);
                          }
                          if (name != null){
                            Provider.of<AllProvider>(context, listen: false).setName(name);
                          }
                          if (user != null) {
                            Provider.of<AllProvider>(context, listen: false)
                                .setUser(user);
                          }
                          if(userId != null){
                            Provider.of<AllProvider>(context, listen: false).setUserId(userId);
                          }
                          if(token != null){
                            Provider.of<AllProvider>(context, listen: false).setToken(token);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Sucesso: ${responseData['message']}')),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InicioView()),
                          );
                          // Navegue para a próxima tela ou faça o que for necessário
                        } else {
                          final responseData = jsonDecode(response.body);
                          print(responseData['message']);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Erro: ${responseData['message']}')),

                          );
                        }
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Erro ao conectar-se ao servidor: $e')),
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
                    'Entrar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Cor do texto do botão
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Não Possui uma conta?"),
                    TextButton(
                      onPressed: () {
                        // Navega para a página de login quando o botão for clicado
                        Navigator.of(context).pushReplacementNamed('/cadastro'); // direcionamento para tela de cadastro
                      },
                      child: const Text(
                        'Cadastre-se aqui',
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
