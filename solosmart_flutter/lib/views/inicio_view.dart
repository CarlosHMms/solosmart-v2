import 'package:flutter/material.dart';
import 'package:solosmart_flutter/views/dashborad_view.dart';
import 'package:solosmart_flutter/views/placas_view.dart';
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

  int _selectedViewIndex = 0;

  List<String> placas = ['Placa 1', 'Placa 2', 'Placa 3'];
  String? selectedPlaca;


  final List<Widget> _views = [];

  @override
  void initState() {
    super.initState();

    _views.addAll([
      PlacasView(
        onAddButtonPressed: () {
          setState(() {
            _selectedViewIndex = 4; 
          });
        },
      ),
      //const HomeView(),
      const DashboardView(),
      const PerfilView(),
      const RelatoriosView(),
      const AddView(),
      const ConfigView(),
      const NotifView(),
      const SuportView(),
    ]);
  }

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
              Expanded(
                child: Container(
                  color: const Color(0xFFF5F8DE),
                  child:
                      _views[_selectedViewIndex],
                ),
              ),
            ],
          ),
          MySupportButton(
            onPressed: () {
              setState(() {
                _selectedViewIndex = 7;
              });
            },
          ),
        ],
      ),
    );
  }
}
