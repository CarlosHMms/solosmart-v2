import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/utils/provider.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AllProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      body: Row(
        children: [
          // Painel principal
          Expanded(
            child: Container(
              color: const Color(0xFFF5F8DE), // Cor de fundo clara
              child: Stack(
                children: [
                  // Conteúdo do painel principal aqui
                  Center(
                    child: Container(
                      width: 934,
                      height: 695,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F8DE),
                        borderRadius: BorderRadius.circular(19),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(-7, 11),
                            blurRadius: 25,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user?['name'] ?? 'Nome do Usuário',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'OpenSans-SemiBold',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            user?['email'] ?? 'email@exemplo.com',
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'OpenSans-Regular',
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Senha: ********',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'OpenSans-Regular',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para os itens do menu
  Widget _menuItem(String title, IconData icon, double topPosition) {
    return Padding(
      padding: const EdgeInsets.only(left: 71.0, top: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Inter-Regular',
            ),
          ),
        ],
      ),
    );
  }
}
