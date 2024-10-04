import 'package:flutter/material.dart';
import 'package:solosmart_flutter/views/login_view.dart';

class MyDrawer extends StatefulWidget {
  final bool isDrawerExpanded;
  final Function(int) onSelectView;
  final Function(bool)
      onToggleDrawer;
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
  });

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
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
                    widget.onSelectView(5); // Ir para a tela de notificações
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
                widget.onSelectView(0); // Mudar para a tela Home
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title:
                  const Text('Perfil', style: TextStyle(color: Colors.white)),
              onTap: () {
                widget.onSelectView(1); // Mudar para a tela de Perfil
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_books, color: Colors.white),
              title: const Text('Relatórios',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                widget.onSelectView(2); // Mudar para a tela de Relatórios
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle, color: Colors.white),
              title: const Text('Adicionar Central',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                widget
                    .onSelectView(3); // Mudar para a tela de Adicionar Central
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Configurações',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                widget.onSelectView(4); // Mudar para a tela de Configurações
              },
            ),
            const Spacer(),
            // Caixa de seleção (DropdownButton) para selecionar a placa
            SizedBox(
              width: 170, // Ajuste da largura do Dropdown
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Selecione a placa',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                value: widget.selectedPlaca,
                dropdownColor: const Color(0xFF6D4C3D),
                onChanged: widget.onPlacaSelected,
                items: widget.placas.map((String placa) {
                  return DropdownMenuItem<String>(
                    value: placa,
                    child: Text(
                      placa,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.white),
              title: const Text('Sair', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
            ),
          ]
        ],
      ),
    );
  }
}
