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
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

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

  void fetchData() async {
    final profileProvider = Provider.of<AllProvider>(context, listen: false);
    final token = profileProvider.token;

    // Convertendo as datas para o formato correto ISO-8601
    final String startDateString = '${startDate.toIso8601String()}';
    final String endDateString = '${endDate.toIso8601String()}';

    try {
      final List<dynamic> listByDate = await _relatorioService
          .fetchGravacoesByDate(startDateString, endDateString, token!);
      setState(() {
        gravacoes = listByDate;
      });
    } catch (e) {
      print('Erro ao buscar gravações: $e');
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
                                _buildDatePicker(
                                  context,
                                  label: '${startDate.toLocal()}',
                                  onDateChanged: (DateTime date) {
                                    setState(() {
                                      startDate = date;
                                    });
                                  },
                                  onTimeChanged: (TimeOfDay time) {
                                    setState(() {
                                      startDate = DateTime(
                                        startDate.year,
                                        startDate.month,
                                        startDate.day,
                                        time.hour,
                                        time.minute,
                                      );
                                    });
                                  },
                                ),
                                const SizedBox(width: 16),
                                _buildDatePicker(
                                  context,
                                  label: '${endDate.toLocal()}',
                                  onDateChanged: (DateTime date) {
                                    setState(() {
                                      endDate = date;
                                    });
                                  },
                                  onTimeChanged: (TimeOfDay time) {
                                    setState(() {
                                      endDate = DateTime(
                                        endDate.year,
                                        endDate.month,
                                        endDate.day,
                                        time.hour,
                                        time.minute,
                                      );
                                    });
                                  },
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: fetchData,
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
                                                items: const [
                                                  DropdownMenuItem<int>(
                                                    value: 10,
                                                    child: Text('10'),
                                                  ),
                                                  DropdownMenuItem<int>(
                                                    value: 20,
                                                    child: Text('20'),
                                                  ),
                                                  DropdownMenuItem<int>(
                                                    value: 30,
                                                    child: Text('30'),
                                                  ),
                                                ],
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

  Widget _buildDatePicker(
    BuildContext context, {
    required String label,
    required Function(DateTime) onDateChanged,
    required Function(TimeOfDay) onTimeChanged,
  }) {
    return GestureDetector(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          final TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(DateTime.now()),
          );
          if (pickedTime != null) {
            final DateTime newDate = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
            onDateChanged(newDate);
            onTimeChanged(pickedTime);
          }
        }
      },
      child: Container(
        width: 180,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
