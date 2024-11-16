import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/services/alertaService.dart';
import 'package:solosmart_flutter/utils/provider.dart';

class NotifView extends StatefulWidget {
  const NotifView({super.key});

  @override
  State<NotifView> createState() => _NotifViewState();
}

class _NotifViewState extends State<NotifView> {
  final AlertaService _alertaService = AlertaService();
  List<dynamic> _alertas = []; // Lista que armazenará os alertas recebidos

  @override
  void initState() {
    super.initState();
    _carregarAlertas(); // Carrega os alertas ao inicializar a tela
  }

  Future<void> _carregarAlertas() async {
    final userProvider = Provider.of<AllProvider>(context, listen: false);
    final token = userProvider.token;
    final placaId = userProvider.placaId;
    try {
      final response = await _alertaService.listarAlertas(placaId!, token!);

      if (response.statusCode == 200) {
        List<dynamic> alertasJson = json.decode(response.body)['data'];
        setState(() {
          _alertas =
              alertasJson; // Atualiza a lista de alertas com os dados da API
        });
      } else {
        throw Exception('Erro ao carregar os alertas: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar os alertas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFFF5F8DE),
              child: Center(
                child: Container(
                  width: 800,
                  height: 650,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F8DE),
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
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Notificações',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'OpenSans-SemiBold',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                for (var alerta in _alertas) {
                                  alerta["descricao"] =
                                      "[Visualizada] ${alerta["descricao"]}";
                                }
                              });
                            },
                            child: const Text(
                              "Visualizar todas",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF41337A),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _alertas.clear(); // Remove todos os alertas
                              });
                            },
                            child: const Text(
                              "Remover todas",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF41337A),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          itemCount: _alertas.length,
                          itemBuilder: (context, index) {
                            // Define a cor de fundo com base no tipo do alerta
                            Color backgroundColor = Colors.white; // Cor padrão
                            if (_alertas[index]["tipo"] ==
                                "Temperatura Baixa") {
                              backgroundColor =
                                  Colors.red[100]!; // Fundo vermelho claro
                            }

                            return Card(
                              color: backgroundColor, // Define a cor do cartão
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 2,
                              child: ListTile(
                                leading: const Icon(
                                  Icons.notification_important,
                                  color: Color(0xFF41337A),
                                ),
                                title: Text(
                                  _alertas[index]["tipo"]!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _alertas[index]["descricao"]!,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Data: ${_alertas[index]["data_alerta"]}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_red_eye),
                                      onPressed: () {
                                        setState(() {
                                          _alertas[index]["descricao"] =
                                              "[Visualizada] ${_alertas[index]["descricao"]}";
                                        });
                                      },
                                      color: const Color(0xFF41337A),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _alertas.removeAt(index);
                                        });
                                      },
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
}
