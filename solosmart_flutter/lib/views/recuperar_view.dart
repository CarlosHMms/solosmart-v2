import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/services/recoveryPassword.dart';
import 'package:solosmart_flutter/utils/provider.dart';
import 'package:solosmart_flutter/views/login_view.dart';
import 'package:solosmart_flutter/views/redefinir_view.dart';

class PasswordRecoveryView extends StatefulWidget {
  const PasswordRecoveryView({super.key});

  @override
  State<PasswordRecoveryView> createState() => _PasswordRecoveryViewState();
}

class _PasswordRecoveryViewState extends State<PasswordRecoveryView> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  // Controladores para os campos de email e código
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  String _email = '';
  String _code = '';
  bool _isCodeSent = false; // Estado para alternar entre email e código
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6D4C3D),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: 350,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F8DE),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/SoloSmart.png',
                  width: 200,
                  height: 100,
                ),
                Text(
                  _isCodeSent ? 'Insira o Código' : 'Recuperar Senha',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                if (!_isCodeSent)
                  TextFormField(
                    controller: _emailController, // Usando o controlador
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
                  )
                else
                  TextFormField(
                    controller: _codeController, // Usando o controlador
                    decoration: const InputDecoration(
                      labelText: 'Código',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSaved: (value) => _code = value ?? '',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o código';
                      } else if (value.length != 6 ||
                          int.tryParse(value) == null) {
                        return 'O código deve conter 6 números';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: isLoading
                      ? null // Desabilita o botão enquanto estiver carregando
                      : () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            if (!_isCodeSent) {
                              setState(() {
                                isLoading =
                                    true; // Exibe o indicador de carregamento
                              });
                              // Enviar email com código
                              try {
                                final response =
                                    await _authService.passwordRecovery(_email);
                                final Map<String, dynamic> responseData =
                                    jsonDecode(response.body);

                                if (response.statusCode == 200) {
                                  final Map<String, dynamic> responseData =
                                      jsonDecode(response.body);
                                  int? code = responseData['data']['code'];
                                  if (code != null) {
                                    Provider.of<AllProvider>(context,
                                            listen: false)
                                        .setCode(code);
                                  }
                                  setState(() {
                                    _isCodeSent = true;
                                    _emailController
                                        .clear(); // Limpar o campo de email
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Sucesso: ${responseData['message']}'),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Erro: ${responseData['email'][0]}'),
                                    ),
                                  );
                                }
                              } catch (e) {
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Erro ao conectar-se ao servidor: $e'),
                                  ),
                                );
                              } finally {
                                setState(() {
                                  isLoading =
                                      false; // Restaura o estado do botão
                                });
                              }
                            } else {
                              // Validar código
                              final codi = Provider.of<AllProvider>(context,
                                      listen: false)
                                  .code
                                  .toString();
                              if (_code == codi) {
                                // Substitua pela lógica de validação real
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Código validado com sucesso!'),
                                  ),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ResetPasswordView(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Código inválido!'),
                                  ),
                                );
                              }
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF41337A),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 115,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          _isCodeSent ? 'Validar' : 'Enviar',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_isCodeSent
                        ? "Não recebeu o código?"
                        : "Lembrou a senha?"),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (_isCodeSent) {
                            _isCodeSent = false;
                            _codeController.clear(); // Limpar o campo de código
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ),
                            );
                          }
                        });
                      },
                      child: Text(
                        _isCodeSent ? 'Reenviar' : 'Faça login',
                        style: const TextStyle(color: Colors.blue),
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
