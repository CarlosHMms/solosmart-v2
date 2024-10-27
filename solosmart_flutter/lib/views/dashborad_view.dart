import 'dart:async';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/utils/provider.dart';
import 'package:solosmart_flutter/services/generateData.dart';

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
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _gerarEDadosAtualizados();
    });
  }

  Future<void> _gerarEDadosAtualizados() async {
    try {
      final profileProvider = Provider.of<AllProvider>(context, listen: false);
      final placaId = profileProvider.placaId;
      final token = profileProvider.token;

      if (placaId == null || token == null) {
        print('Erro: placaId ou token não definidos');
        return;
      }

      await profileProvider.atualizarDados(placaId);
    } catch (e) {
      print('Erro ao gerar ou atualizar dados: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dadosProvider = Provider.of<AllProvider>(context);
    final dados = dadosProvider.dados;

    final double umidadeAr =
        double.tryParse(dados?['umidade_ar']?.toString() ?? '0') ?? 0;
    final double umidadeSolo =
        double.tryParse(dados?['umidade_solo']?.toString() ?? '0') ?? 0;

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
                        // Card para Níveis de Umidade
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Níveis de Umidade',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: SizedBox(
                                        height:
                                            200,
                                        child: PieChart(
                                          PieChartData(
                                            sections: _buildPieChartSections(
                                                umidadeAr, umidadeSolo),
                                            centerSpaceRadius: 40,
                                            sectionsSpace: 4,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildLegendItem(
                                            color: Colors.redAccent,
                                            label: 'Baixa Umidade',
                                          ),
                                          const SizedBox(height: 10),
                                          _buildLegendItem(
                                            color: Colors.yellowAccent,
                                            label: 'Média Umidade',
                                          ),
                                          const SizedBox(height: 10),
                                          _buildLegendItem(
                                            color: Colors.greenAccent,
                                            label: 'Alta Umidade',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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


  List<PieChartSectionData> _buildPieChartSections(
      double umidadeAr, double umidadeSolo) {
    // Define categorias de umidade para o gráfico de pizza
    const double baixaUmidade = 30.0;
    const double mediaUmidade = 70.0;

    // Calculando os valores para as seções do ar
    double valorBaixaUmidadeAr = umidadeAr < baixaUmidade ? umidadeAr : 0;
    double valorMediaUmidadeAr =
        (umidadeAr >= baixaUmidade && umidadeAr <= mediaUmidade)
            ? umidadeAr
            : 0;
    double valorAltaUmidadeAr = umidadeAr > mediaUmidade ? umidadeAr : 0;

    // Calculando os valores para as seções do solo
    double valorBaixaUmidadeSolo = umidadeSolo < baixaUmidade ? umidadeSolo : 0;
    double valorMediaUmidadeSolo =
        (umidadeSolo >= baixaUmidade && umidadeSolo <= mediaUmidade)
            ? umidadeSolo
            : 0;
    double valorAltaUmidadeSolo = umidadeSolo > mediaUmidade ? umidadeSolo : 0;

    return [
      // Seção de baixa umidade do ar
      PieChartSectionData(
        value: valorBaixaUmidadeAr,
        color: Colors.redAccent,
        title: valorBaixaUmidadeAr > 0
            ? 'Ar: ${valorBaixaUmidadeAr.toStringAsFixed(1)}%'
            : '',
        radius: 60,
      ),
      // Seção de média umidade do ar
      PieChartSectionData(
        value: valorMediaUmidadeAr,
        color: Colors.yellowAccent,
        title: valorMediaUmidadeAr > 0
            ? 'Ar: ${valorMediaUmidadeAr.toStringAsFixed(1)}%'
            : '',
        radius: 60,
      ),
      // Seção de alta umidade do ar
      PieChartSectionData(
        value: valorAltaUmidadeAr,
        color: Colors.greenAccent,
        title: valorAltaUmidadeAr > 0
            ? 'Ar: ${valorAltaUmidadeAr.toStringAsFixed(1)}%'
            : '',
        radius: 60,
      ),
      // Seção de baixa umidade do solo
      PieChartSectionData(
        value: valorBaixaUmidadeSolo,
        color: Colors.redAccent.withOpacity(0.5),
        title: valorBaixaUmidadeSolo > 0
            ? 'Solo: ${valorBaixaUmidadeSolo.toStringAsFixed(1)}%'
            : '',
        radius: 60,
      ),
      // Seção de média umidade do solo
      PieChartSectionData(
        value: valorMediaUmidadeSolo,
        color: Colors.yellowAccent.withOpacity(0.5),
        title: valorMediaUmidadeSolo > 0
            ? 'Solo: ${valorMediaUmidadeSolo.toStringAsFixed(1)}%'
            : '',
        radius: 60,
      ),
      // Seção de alta umidade do solo
      PieChartSectionData(
        value: valorAltaUmidadeSolo,
        color: Colors.greenAccent.withOpacity(0.5),
        title: valorAltaUmidadeSolo > 0
            ? 'Solo: ${valorAltaUmidadeSolo.toStringAsFixed(1)}%'
            : '',
        radius: 60,
      ),
    ];
  }


  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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
