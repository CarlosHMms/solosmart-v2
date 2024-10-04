import 'package:flutter/material.dart';
import 'package:solosmart_flutter/views/home_view.dart';
import 'package:solosmart_flutter/views/perfil_view.dart';
import 'package:solosmart_flutter/views/relatorios_view.dart';
import 'package:solosmart_flutter/views/add_view.dart';
import 'package:solosmart_flutter/views/config_view.dart';
import 'package:solosmart_flutter/views/notif_view.dart';
import 'package:solosmart_flutter/views/suport_view.dart';
import 'package:solosmart_flutter/components/my_drawer.dart';
import 'package:solosmart_flutter/components/my_supportbutton.dart';

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

  // Lista de placas para o Dropdown
  List<String> placas = ['Placa 1', 'Placa 2', 'Placa 3'];
  String? selectedPlaca;

  // Definir quais telas (views) serão exibidas com base no índice
  final List<Widget> _views = [
    const HomeView(),
    const PerfilView(),
    const RelatoriosView(),
    const AddView(),
    const ConfigView(),
    const NotifView(),
    const SuportView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8DE),
      body: Stack(
        children: [
          Row(
            children: [
              // Componente do menu lateral
              MyDrawer(
                isDrawerExpanded: _isDrawerExpanded,
                onSelectView: (int index) {
                  setState(() {
                    _selectedViewIndex = index;
                  });
                },
                onToggleDrawer: (bool isExpanded) {
                  setState(() {
                    _isDrawerExpanded = isExpanded;
                  });
                },
                placas: placas,
                selectedPlaca: selectedPlaca,
                onPlacaSelected: (String? newValue) {
                  setState(() {
                    selectedPlaca = newValue;
                  });
                },
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
          // Botão flutuante de suporte
          MySupportButton(
            onPressed: () {
              setState(() {
                _selectedViewIndex = 6;
              });
            },
          ),
        ],
      ),
    );
  }
}
