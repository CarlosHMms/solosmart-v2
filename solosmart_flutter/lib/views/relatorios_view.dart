import 'package:flutter/material.dart';

class RelatoriosView extends StatelessWidget {
  const RelatoriosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8DE),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDatePicker(context, label: 'Sexta, 13/10/23'),
                const SizedBox(width: 16),
                _buildDatePicker(context, label: 'Quinta, 29/11/23'),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Implementar funcionalidade de filtro
                  },
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
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255), // Cor de fundo
                    borderRadius:
                        BorderRadius.circular(16), // Bordas arredondadas
                    border: Border.all(
                        color: Colors.grey,
                        width: 1), // Borda ao redor da tabela
                  ),
                  padding: const EdgeInsets.all(8), // Espaçamento interno
                  child: SingleChildScrollView(
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      border: TableBorder(
                        horizontalInside: BorderSide(
                            color: Colors.grey[400]!,
                            width: 1), // Linhas horizontais
                        verticalInside: BorderSide(
                            color: Colors.grey[400]!,
                            width: 1), // Linhas verticais
                      ),
                      children: [
                        // Cabeçalho da Tabela
                        TableRow(
                          decoration: const BoxDecoration(
                            color: Color(0xFF41337A), // Fundo do cabeçalho
                          ),
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  'Hora',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  'Data',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  'Situação',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Linhas da Tabela
                        ...List.generate(15, (index) {
                          return TableRow(
                            decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? Colors.white
                                  : Colors
                                      .grey[200], // Cor alternada para linhas
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Center(child: Text('Hora ${index + 1}')),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Center(child: Text('Data ${index + 1}')),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: Text(index % 2 == 0 ? 'Bom' : 'Ruim'),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            MainAxisAlignment.end, // Garante alinhamento ao final
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100), // Ajuste aqui a altura
            child: FloatingActionButton(
              heroTag: 'exportButton',
              onPressed: () {
                // Implementar funcionalidade de exportar dados
              },
              backgroundColor: const Color(0xFF41337A),
              child: const Icon(Icons.download),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, {required String label}) {
    return InkWell(
      onTap: () {
        // Implementar seleção de data
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFF41337A)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.calendar_today, color: Color(0xFF41337A)),
          ],
        ),
      ),
    );
  }
}
