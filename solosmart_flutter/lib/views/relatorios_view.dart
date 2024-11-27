import 'package:flutter/material.dart';

class RelatoriosView extends StatelessWidget {
  const RelatoriosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8DE), // Fundo padrão da tela
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
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                padding: const EdgeInsets.all(8),
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Center(
                                              child: Text(
                                                'Hora',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Center(
                                              child: Text(
                                                'Data',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Center(
                                              child: Text(
                                                'Situação',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ...List.generate(15, (index) {
                                        return TableRow(
                                          decoration: BoxDecoration(
                                            color: index % 2 == 0
                                                ? Colors.white
                                                : Colors.grey[200],
                                          ),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Center(
                                                  child: Text(
                                                      'Hora ${index + 1}')),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Center(
                                                  child: Text(
                                                      'Data ${index + 1}')),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Center(
                                                child: Text(index % 2 == 0
                                                    ? 'Bom'
                                                    : 'Ruim'),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 125,
            right: 20,
            child: FloatingActionButton(
              heroTag: 'exportButton',
              onPressed: () {
                // Implementar funcionalidade de exportar dados
              },
              backgroundColor: const Color(0xFF41337A),
              child: const Icon(
                Icons.download,
                color: Colors.white, // Cor do ícone alterada para branco
              ),
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
