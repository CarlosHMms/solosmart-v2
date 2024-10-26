import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/utils/provider.dart';
import 'package:solosmart_flutter/services/generateData.dart'; // Certifique-se de ajustar o caminho

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  Timer? _timer;
  final Generatedata _generatedata = Generatedata();

  @override
  void initState() {
    super.initState();
    // Inicia o Timer para gerar e atualizar os dados a cada 10 segundos
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _gerarEDadosAtualizados();
    });
  }

  Future<void> _gerarEDadosAtualizados() async {
    try {
      final profileProvider = Provider.of<AllProvider>(context, listen: false);
      final placaId =
          profileProvider.placaId; // Obtem o ID da placa selecionada
      final token = profileProvider.token;

      // Verifique se placaId e token não são nulos
      if (placaId == null || token == null) {
        print('Erro: placaId ou token não definidos');
        return; // Retorne se qualquer um deles for nulo
      }

      await profileProvider
          .atualizarDados(placaId); // Atualiza os dados no Provider
    } catch (e) {
      print('Erro ao gerar ou atualizar dados: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela o Timer ao sair da tela
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dadosProvider = Provider.of<AllProvider>(context);
    final dados = dadosProvider.dados;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8DE),
      body: Row(
        children: [
          Expanded(
            child: Container(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: _buildDashboardCard(
                                context,
                                title: 'Temperatura Atual',
                                value:
                                    '${dados?['temperatura_ar']?.toString() ?? 'N/A'} °C',
                                icon: Icons.thermostat_outlined,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: _buildDashboardCard(
                                context,
                                title: 'Umidade do Ar',
                                value:
                                    '${dados?['umidade_ar']?.toString() ?? 'N/A'} %',
                                icon: Icons.water_drop_outlined,
                                color: Colors.blueAccent,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: _buildDashboardCard(
                                context,
                                title: 'Umidade do Solo',
                                value:
                                    '${dados?['umidade_solo']?.toString() ?? 'N/A'} %',
                                icon: Icons.grass_outlined,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
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

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 300,
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(19),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(-7, 11),
            blurRadius: 25,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
