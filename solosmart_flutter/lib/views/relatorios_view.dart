import 'package:flutter/material.dart';

class RelatoriosView extends StatefulWidget {
  const RelatoriosView({Key? key}) : super(key: key);

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
        backgroundColor: const Color(0xFF41337A), // Cor do AppBar
      ),
      body: Container(
        color: const Color(0xFFF5F8DE), // Cor de fundo das outras views
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
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Hora',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Situação',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                  rows: _tabelaDados.map((dados) {
                    return DataRow(cells: [
                      DataCell(Text(dados['hora']!)),
                      DataCell(Text(dados['data']!)),
                      DataCell(Text(dados['situacao']!)),
                    ]);
                  }).toList(),
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
