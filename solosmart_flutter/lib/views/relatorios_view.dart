import 'package:flutter/material.dart';

class RelatoriosView extends StatefulWidget {
  const RelatoriosView({super.key});

  @override
  State<RelatoriosView> createState() => _RelatoriosViewState();
}

class _RelatoriosViewState extends State<RelatoriosView> {
  // Exemplo de dados para a tabela
  final List<Map<String, String>> _tabelaDados = [
    {"hora": "08:00", "data": "2024-10-29", "situacao": "Normal"},
    {"hora": "12:00", "data": "2024-10-29", "situacao": "Alerta"},
    {"hora": "16:00", "data": "2024-10-29", "situacao": "Crítico"},
    // Adicione mais dados conforme necessário
  ];

  final TextEditingController _dataFiltroController = TextEditingController();

  // Função para exibir todos os dados da tabela
  void _exibirTodosDados() {
    // Função de lógica para exibir todos os dados (atualmente não filtrado)
  }

  // Função para baixar a tabela (implementação conforme a necessidade)
  void _baixarTabela() {
    // Função de lógica para baixar a tabela (exemplo básico)
    print("Baixando tabela...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F8DE),
      ),
      body: Container(
        color: const Color(0xFFF5F8DE), // Cor de fundo
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de Filtro por Data
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dataFiltroController,
                    decoration: InputDecoration(
                      hintText: 'Filtrar por data (AAAA-MM-DD)',
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _exibirTodosDados,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF41337A),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Exibir Todos',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tabela de Dados
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white, // Cor de fundo para os dados
                  ),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                    const Color(0xFF41337A)), // Cor de fundo dos títulos
                    columnSpacing: 280,
                    columns: const [
                      DataColumn(
                        label: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Hora',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white, // Cor do texto
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Data',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Situação',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: _tabelaDados.map((dados) {
                      return DataRow(
                        cells: [
                          DataCell(Text(
                            dados['hora']!,
                            style: const TextStyle(fontSize: 16),
                          )),
                          DataCell(Text(
                            dados['data']!,
                            style: const TextStyle(fontSize: 16),
                          )),
                          DataCell(Text(
                            dados['situacao']!,
                            style: const TextStyle(fontSize: 16),
                          )),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Botão de Baixar Tabela
            ElevatedButton(
              onPressed: _baixarTabela,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF41337A),
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Baixar Tabela',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
