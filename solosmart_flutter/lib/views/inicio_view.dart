import 'package:flutter/material.dart';
import 'package:solosmart_flutter/views/login_view.dart';
import 'package:solosmart_flutter/views/perfil_view.dart';

class InicioView extends StatefulWidget{
  const InicioView({super.key});

  @override
  State<InicioView> createState() => _InicioViewState();
}
class _InicioViewState extends State<InicioView>{
  final _formkey = GlobalKey<FormState>();
  bool _isDrawerExpanded = true;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8DE),
      body: Row(
        children: [
          // Barra lateral (Drawer) customizada
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
                          MaterialPageRoute(builder: (context) => const LoginView()),
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
