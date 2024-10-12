import 'package:flutter/material.dart';

class ResetPasswordView extends StatefulWidget {
  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? token;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Captura o token da URL
    final Uri? uri = ModalRoute.of(context)?.settings.arguments as Uri?;
    token = uri?.queryParameters['token'];
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      // Aqui você pode chamar seu backend para redefinir a senha usando o token e a nova senha.
      print('Senha: ${_passwordController.text}, Token: $token');
      // Enviar a senha e o token para o backend
      // Por exemplo: AuthService.resetPassword(token, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6d4c3d),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 612,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFf5f8de),
              borderRadius: BorderRadius.circular(19),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Solo',
                    style: TextStyle(
                      fontFamily: 'Academy',
                      color: Color(0xFF31e981),
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    'Smart',
                    style: TextStyle(
                      fontFamily: 'Academy',
                      color: Color(0xFF41337a),
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Nova Senha',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Campo de Senha
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a senha';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  // Campo de Repetir Senha
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Repetir Senha',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, repita a senha';
                      }
                      if (value != _passwordController.text) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40),
                  // Botões de Cancelar e Redefinir
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para cancelar
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          side: BorderSide(color: Color(0xFF41337a), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _resetPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF41337a),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: Text(
                            'Redefinir',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
