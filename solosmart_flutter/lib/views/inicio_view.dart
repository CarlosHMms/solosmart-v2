import 'package:flutter/material.dart';
import 'package:solosmart_flutter/views/login_view.dart';
import 'package:solosmart_flutter/views/perfil_view.dart';

class InicioView extends StatefulWidget {
  const InicioView({super.key});

  @override
  State<InicioView> createState() => _InicioViewState();
}

class _InicioViewState extends State<InicioView> {
  final _formkey = GlobalKey<FormState>();
  bool _isDrawerExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8DE),
      body: Row(
        children: [
          // Barra lateral (Drawer) customizada
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _isDrawerExpanded ? 210 : 70, // Largura da barra lateral
            color: const Color(0xFF6D4C3D),
            child: Column(
              children: [
                // Ícone de notificação alinhado à direita
                if (_isDrawerExpanded)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications,
                            color: Colors.white),
                        onPressed: () {
                          // Ação do botão de notificação
                        },
                      ),
                    ],
                  ),
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
                    leading:
                        const Icon(Icons.library_books, color: Colors.white),
                    title: const Text(
                      'Relatórios',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Ação do botão
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add_circle, color: Colors.white),
                    title: const Text(
                      'Adicionar Central',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      // Ação do botão
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
                  // Adiciona o Spacer para empurrar o botão 'Sair' para o final
                  const Spacer(),
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
          // Conteúdo principal
          Expanded(
            child: Container(
              color: const Color(0xFFF5F8DE),
              child: const Center(
                child: Text("Conteúdo principal"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
