import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/services/placaService.dart';
import 'package:solosmart_flutter/services/generateData.dart';
import 'package:solosmart_flutter/utils/provider.dart';
import 'package:solosmart_flutter/views/dashborad_view.dart';
import 'package:solosmart_flutter/views/placas_view.dart';
import 'package:solosmart_flutter/views/perfil_view.dart';
import 'package:solosmart_flutter/views/relatorios_view.dart';
import 'package:solosmart_flutter/views/add_view.dart';
import 'package:solosmart_flutter/views/config_view.dart';
import 'package:solosmart_flutter/views/notif_view.dart';
import 'package:solosmart_flutter/views/faq_view.dart';
import 'package:solosmart_flutter/views/ticket_view.dart';
import 'package:solosmart_flutter/views/suport_view.dart';
import 'package:solosmart_flutter/components/my_drawer.dart';
import 'package:solosmart_flutter/components/my_supportbutton.dart';
import 'dart:convert';

class InicioView extends StatefulWidget {
  const InicioView({super.key});

  @override
  State<InicioView> createState() => _InicioViewState();
}

class _InicioViewState extends State<InicioView> {
  final _formkey = GlobalKey<FormState>();
  bool _isDrawerExpanded = true;
  int _selectedViewIndex = 0;

  List<dynamic> placas = [];
  final ValueNotifier<String?> selectedPlacaNotifier =
      ValueNotifier<String?>(null);
  final PlacaService _placaController = PlacaService();
  final Generatedata _generatedata = Generatedata();
  String? token;

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
        onDashboardSelected: (int index) {
          setState(() {
            _selectedViewIndex = index;
          });
        },
        selectedPlacaNotifier: selectedPlacaNotifier,
      ),
      const DashboardView(),
      const PerfilView(),
      const RelatoriosView(),
      const AddView(),
      const ConfigView(),
      const NotifView(),
      FAQView(
        onTicketButtonPressed: _onTicketButtonPressed, // Passa a função aqui
      ),
      const TicketView(),
    ]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    token = Provider.of<AllProvider>(context).token;

    if (token != null) {
      _carregarPlacas();
    }
  }

  Future<void> _carregarPlacas() async {
    try {
      final response = await _placaController.listarPlaca(token!);

      if (response.statusCode == 200) {
        List<dynamic> placasJson = json.decode(response.body)['data'];
        setState(() {
          placas = placasJson;
        });
      } else {
        throw Exception('Erro ao carregar as placas: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar as placas: $e');
    }
  }

  Future<void> _buscarDados(int placaId) async {
    try {
      final response = await _generatedata.buscarDados(placaId, token!);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        Map<String, dynamic>? dados = responseData['data'];
        if (dados != null) {
          Provider.of<AllProvider>(context, listen: false).setDados(dados);
        }
        print('Dados gerados com sucesso para a placa $placaId.');
        setState(() {
          _selectedViewIndex = 1; // Muda para o DashboardView
        });
      } else {
        final response = await _generatedata.gerarDados(placaId, token!);

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          Map<String, dynamic>? dados = responseData['data'];
          if (dados != null) {
            Provider.of<AllProvider>(context, listen: false).setDados(dados);
          }
          setState(() {
            _selectedViewIndex = 1; // Muda para o DashboardView
          });
        }
      }
    } catch (e) {
      print('Erro ao gerar dados: $e');
    }
  }

  void _onPlacaSelecionada(String? newValue) {
    setState(() {
      selectedPlacaNotifier.value = newValue;
    });

    int? placaId =
        placas.firstWhere((placa) => placa['name'] == newValue)['id'];
    if (placaId != null) {
      _buscarDados(placaId);
      Provider.of<AllProvider>(context, listen: false).setPlacaId(placaId);
    }
  }

  // Função que será chamada para mudar para a tela de TicketView
  void _onTicketButtonPressed() {
    setState(() {
      _selectedViewIndex = 8; // Define o índice da TicketView
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8DE),
      body: Stack(
        children: [
          Row(
            children: [
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
                placas: placas.isNotEmpty
                    ? placas.map((placa) => placa['name'].toString()).toList()
                    : [],
                selectedPlaca: selectedPlacaNotifier.value,
                onPlacaSelected: _onPlacaSelecionada,
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFFF5F8DE),
                  child: _views[_selectedViewIndex],
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
