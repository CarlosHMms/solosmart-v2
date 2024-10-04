import 'package:flutter/material.dart';
import 'package:solosmart_flutter/views/login_view.dart';
import 'package:solosmart_flutter/views/perfil_view.dart';
import 'package:solosmart_flutter/views/relatorios_view.dart';
import 'package:solosmart_flutter/views/home_view.dart';
import 'package:solosmart_flutter/views/add_view.dart';
import 'package:solosmart_flutter/views/config_view.dart';
import 'package:solosmart_flutter/views/notif_view.dart';
import 'package:solosmart_flutter/views/suport_view.dart';

class InicioView extends StatefulWidget {
  const InicioView({super.key});

  @override
  State<InicioView> createState() => _InicioViewState();
}

class _InicioViewState extends State<InicioView> {
  final _formkey = GlobalKey<FormState>();
  bool _isDrawerExpanded = true;

  // Controlador para as telas (views)
  int _selectedViewIndex = 0;

  // Definir quais telas (views) serão exibidas com base no índice
  final List<Widget> _views = [
    const HomeView(), // Tela inicial (Home)
    const PerfilView(), // Tela de perfil
    const RelatoriosView(),
    const AddView(),
    const ConfigView(), // Tela de relatórios
    const NotifView(),
    const SuportView(),
    // Adicione outras telas que você quiser
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8DE),
      body: Stack(
        children: [
          Row(
            children: [
              // Barra lateral (Drawer) customizada
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _isDrawerExpanded ? 200 : 70, // Largura da barra lateral
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
                              setState(() {
                                _selectedViewIndex = 5;
                              });
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
                          // Mudar para a tela Home
                          setState(() {
                            _selectedViewIndex = 0;
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person, color: Colors.white),
                        title: const Text(
                          'Perfil',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          // Mudar para a tela de Perfil
                          setState(() {
                            _selectedViewIndex = 1;
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.library_books,
                            color: Colors.white),
                        title: const Text(
                          'Relatórios',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          // Mudar para a tela de Relatórios
                          setState(() {
                            _selectedViewIndex = 2;
                          });
                        },
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.add_circle, color: Colors.white),
                        title: const Text(
                          'Adicionar Central',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          // Mudar para a tela de Adicionar Central
                          setState(() {
                            _selectedViewIndex = 3;
                          });
                        },
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.settings, color: Colors.white),
                        title: const Text(
                          'Configurações',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          // Mudar para a tela de Configurações
                          setState(() {
                            _selectedViewIndex = 4;
                          });
                        },
                      ),
                      // Adiciona o Spacer para empurrar o botão 'Sair' para o final
                      const Spacer(),
                      ListTile(
                        leading:
                            const Icon(Icons.exit_to_app, color: Colors.white),
                        title: const Text(
                          'Sair',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          // Ação do botão de sair
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
              // Conteúdo principal que muda conforme a opção do menu
              Expanded(
                child: Container(
                  color: const Color(0xFFF5F8DE),
                  child:
                      _views[_selectedViewIndex], // Exibir a tela selecionada
                ),
              ),
            ],
          ),
          // Bola roxa no canto inferior direito
          Positioned(
            bottom: 20,
            right: 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Bola roxa
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(65, 51, 122, 1), // Cor roxa
                    shape: BoxShape.circle,
                  ),
                ),
                // Botão com o ícone de headset
                IconButton(
                  icon: const Icon(Icons.headset_mic, color: Colors.white),
                  iconSize: 40, // Tamanho do ícone
                  onPressed: () {
                    // Ação ao clicar no botão
                    setState(() {
                      _selectedViewIndex = 6;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
