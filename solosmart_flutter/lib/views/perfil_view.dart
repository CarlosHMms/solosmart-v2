import 'package:flutter/material.dart';
import 'package:solosmart_flutter/views/login_view.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  bool _isDrawerExpanded = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Painel lateral
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _isDrawerExpanded ? 300 : 70, // Largura da barra lateral
            color: const Color(0xFF6D4C3D),

            child: Column(
              children: [
                Image.asset(
                  'assets/images/IconSoloSmart.png',
                  width: 200,
                  height: 100,
                ),
                IconButton(
                  icon: Icon(
                    _isDrawerExpanded ? Icons.arrow_back : Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isDrawerExpanded = !_isDrawerExpanded;
                    });
                  },
                ),
                if (_isDrawerExpanded) ...[
                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.white),
                    title: const Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Ação do botão
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.white),
                    title: const Text(
                      'Perfil',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Ação do botão
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PerfilView()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.white),
                    title: const Text(
                      'Configurações',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Ação do botão
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app, color: Colors.white),
                    title: const Text(
                      'Sair',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Ação do botão
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()),
                      );
                    },
                  ),
                ]
              ],
            ),
          ),

          // Painel principal
          Expanded(
            child: Container(
              color: Color(0xFFF5F8DE), // Cor de fundo clara
              child: Stack(
                children: [
                  // Conteúdo do painel principal aqui
                  Center(
                    child: Container(
                      width: 934,
                      height: 695,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F8DE),
                        borderRadius: BorderRadius.circular(19),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(-7, 11),
                            blurRadius: 25,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Exemplo de um nome de usuário
                          Text(
                            'Nome do Usuário',
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
      padding: EdgeInsets.only(left: 71.0, top: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 26),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
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
