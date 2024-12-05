import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:solosmart_flutter/utils/provider.dart';
import 'package:solosmart_flutter/services/RelatorioService.dart';
import 'package:http/http.dart' as http;

class RelatoriosView extends StatefulWidget {
  const RelatoriosView({super.key});

  @override
  State<RelatoriosView> createState() => _RelatoriosViewState();
}

class _RelatoriosViewState extends State<RelatoriosView> {
  List<dynamic> gravacoes = [];
  bool isLoading = true;
  final RelatorioService _relatorioService = RelatorioService();
  int currentPage = 1;
  int itemsPerPage = 10; // Número inicial de itens por página

  @override
  void initState() {
    super.initState();
    fetchGravacoes();
  }

  Future<void> fetchGravacoes() async {
    setState(() {
      isLoading = true;
    });
    final profileProvider = Provider.of<AllProvider>(context, listen: false);
    final token = profileProvider.token;

    try {
      final gravacoesList = await _relatorioService.index(token!);
      setState(() {
        gravacoes = gravacoesList;
      });
    } catch (e) {
      print('Erro ao buscar gravações: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calcula o índice inicial e final para exibir os itens da página atual
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    List<dynamic> currentPageItems = gravacoes.sublist(
      startIndex,
      endIndex > gravacoes.length ? gravacoes.length : endIndex,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8DE),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: const EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F8DE),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'Relatórios',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Open Sans',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildDatePicker(context,
                                    label: 'Sexta, 13/10/23'),
                                const SizedBox(width: 16),
                                _buildDatePicker(context,
                                    label: 'Quinta, 29/11/23'),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: fetchGravacoes,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF41337A),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                  ),
                                  child: const Text(
                                    'Filtrar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(1),
                                              1: FlexColumnWidth(2),
                                              2: FlexColumnWidth(2),
                                              3: FlexColumnWidth(2),
                                              4: FlexColumnWidth(2),
                                              5: FlexColumnWidth(2),
                                            },
                                            border: TableBorder(
                                              horizontalInside: BorderSide(
                                                color: Colors.grey[400]!,
                                                width: 1,
                                              ),
                                              verticalInside: BorderSide(
                                                color: Colors.grey[400]!,
                                                width: 1,
                                              ),
                                            ),
                                            children: [
                                              TableRow(
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF41337A),
                                                ),
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Center(
                                                      child: Text(
                                                        'ID',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Center(
                                                      child: Text(
                                                        'Placa ID',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Center(
                                                      child: Text(
                                                        'Temp. Ar (°C)',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Center(
                                                      child: Text(
                                                        'Umid. Ar (%)',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Center(
                                                      child: Text(
                                                        'Umid. Solo (%)',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    child: Center(
                                                      child: Text(
                                                        'Data e Hora',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          // Exibe os itens da página atual
                                          Table(
                                            children: currentPageItems
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final index = entry.key;
                                              final gravacao = entry.value;

                                              return TableRow(
                                                decoration: BoxDecoration(
                                                  color: index % 2 == 0
                                                      ? Colors.white
                                                      : Colors.grey[200],
                                                ),
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Center(
                                                        child: Text(
                                                            gravacao['id']
                                                                .toString())),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Center(
                                                        child: Text(
                                                            gravacao['placa_id']
                                                                .toString())),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Center(
                                                        child: Text(gravacao[
                                                                'temperatura_ar']
                                                            .toString())),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Center(
                                                        child: Text(gravacao[
                                                                'umidade_ar']
                                                            .toString())),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Center(
                                                        child: Text(gravacao[
                                                                'umidade_solo']
                                                            .toString())),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Center(
                                                        child: Text(gravacao[
                                                                'data_registro']
                                                            .toString())),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                          // Controle de página
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: currentPage > 1
                                                    ? () {
                                                        setState(() {
                                                          currentPage--;
                                                        });
                                                      }
                                                    : null,
                                                child: const Text('Voltar'),
                                              ),
                                              const SizedBox(width: 16),
                                              ElevatedButton(
                                                onPressed: currentPage <
                                                        (gravacoes.length /
                                                                itemsPerPage)
                                                            .ceil()
                                                    ? () {
                                                        setState(() {
                                                          currentPage++;
                                                        });
                                                      }
                                                    : null,
                                                child: const Text('Avançar'),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Itens por página: ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              DropdownButton<int>(
                                                value: itemsPerPage,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    itemsPerPage = newValue!;
                                                    currentPage =
                                                        1; // Reinicia a página
                                                  });
                                                },
                                                items: [10, 20, 30, 50]
                                                    .map<DropdownMenuItem<int>>(
                                                        (int value) {
                                                  return DropdownMenuItem<int>(
                                                    value: value,
                                                    child:
                                                        Text(value.toString()),
                                                  );
                                                }).toList(),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, {required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, color: Color(0xFF41337A)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF41337A),
            ),
          ),
        ],
      ),
    );
  }
}
