import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/services/auth_user.dart';
import 'package:solosmart_flutter/utils/provider.dart';
import 'package:solosmart_flutter/views/login_view.dart';

class MyDrawer extends StatefulWidget {
  final bool isDrawerExpanded;
  final Function(int) onSelectView;
  final Function(bool) onToggleDrawer;
  final List<String> placas;
  final String? selectedPlaca;
  final Function(String?) onPlacaSelected;

  const MyDrawer({
    super.key,
    required this.isDrawerExpanded,
    required this.onSelectView,
    required this.onToggleDrawer,
    required this.placas,
    required this.selectedPlaca,
    required this.onPlacaSelected,
    required void Function() onMinhasSolicitacoesPressed,
  });

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final AuthService _authService = AuthService();
  String token = '';

  @override
  Widget build(BuildContext context) {
    token = Provider.of<AllProvider>(context).token!;

    // Remover duplicatas da lista de placas, caso haja
    List<String> uniquePlacas = widget.placas.toSet().toList();

    // Verificar se o valor selecionado é válido na lista de placas
    String? selectedPlaca = widget.selectedPlaca;
    if (selectedPlaca != null && !uniquePlacas.contains(selectedPlaca)) {
      selectedPlaca = uniquePlacas.isNotEmpty ? uniquePlacas[0] : null;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: widget.isDrawerExpanded ? 210 : 70, // Largura da barra lateral
      color: const Color(0xFF6D4C3D),
      child: Column(
        children: [
          // Ícone de notificação alinhado à direita
          if (widget.isDrawerExpanded)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                    widget.onSelectView(6); // Ir para a tela de notificações
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
              widget.isDrawerExpanded ? Icons.arrow_back : Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              widget.onToggleDrawer(!widget.isDrawerExpanded);
            },
          ),
          if (widget.isDrawerExpanded) ...[
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                widget.onSelectView(1); // Mudar para a tela Home
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title:
                  const Text('Perfil', style: TextStyle(color: Colors.white)),
              onTap: () {
                widget.onSelectView(2); // Mudar para a tela de Perfil
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_books, color: Colors.white),
              title: const Text('Relatórios',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                widget.onSelectView(3); // Mudar para a tela de Relatórios
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle, color: Colors.white),
              title: const Text('Adicionar Central',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                widget
                    .onSelectView(4); // Mudar para a tela de Adicionar Central
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Configurações',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                widget.onSelectView(5); // Mudar para a tela de Configurações
              },
            ),
            const Spacer(),
            // Caixa de seleção (DropdownButton) para selecionar a placa
            SizedBox(
              width: 165,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Selecionar Central',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                value: selectedPlaca?.isEmpty ?? true
                    ? null
                    : selectedPlaca, // Corrigido para null
                dropdownColor: const Color(0xFF6D4C3D),
                onChanged: (String? newValue) {
                  if (newValue != null && uniquePlacas.contains(newValue)) {
                    widget.onPlacaSelected(newValue);
                  }
                },
                items: uniquePlacas.isEmpty
                    ? [] // Se não houver placas, não exibe o Dropdown
                    : [
                        // Adiciona o placeholder como o primeiro item, se selectedPlaca for null
                        if (selectedPlaca == null || selectedPlaca!.isEmpty)
                          const DropdownMenuItem<String>(
                            value:
                                null, // Corrigido para null no caso de placeholder
                            child: Text(
                              '--',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        // Lista de placas
                        ...uniquePlacas.map((String placa) {
                          return DropdownMenuItem<String>(
                            value: placa,
                            child: Text(
                              placa,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                      ],
              ),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.white),
              title: const Text('Sair', style: TextStyle(color: Colors.white)),
              onTap: () async {
                // Função para realizar o logout
                final response = await _authService.logout(token);
                if (response.statusCode == 200) {
                  print(response.body);
                }

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ]
        ],
      ),
    );
  }
}
