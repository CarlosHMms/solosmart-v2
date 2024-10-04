import 'package:flutter/material.dart';
import 'package:solosmart_flutter/views/notif_view.dart';

class NotifView extends StatefulWidget {
  const NotifView({super.key});

  @override
  State<NotifView> createState() => _NotifViewState();
}

class _NotifViewState extends State<NotifView> {
  final bool _isDrawerExpanded = true;
  @override
  Widget build(BuildContext context) {
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Exemplo de um nome de usuário
                          Text(
                            'Orlando',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'OpenSans-SemiBold',
                            ),
                          ),
                          SizedBox(height: 20),
                          // Exemplo de informação de contato
                          Text(
                            'email@exemplo.com',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'OpenSans-Regular',
                            ),
                          ),
                          Text(
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
