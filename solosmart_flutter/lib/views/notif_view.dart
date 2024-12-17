import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/utils/provider.dart';

class NotifView extends StatefulWidget {
  const NotifView({super.key});

  @override
  State<NotifView> createState() => _NotifViewState();
}

class _NotifViewState extends State<NotifView> {
  String _token = '';
  final List<Map<String, String>> _notificacoes = [];
  late Timer _pollingTimer;
  @override
  void initState() {
    super.initState();
    _iniciarPolling(); // Inicia o polling assim que a tela é criada
  }

  @override
  void dispose() {
    _pollingTimer.cancel(); // Cancela o Timer quando a tela for descartada
    super.dispose();
  }

  void _iniciarPolling() {
    // Configura o Timer para chamar a função a cada 10 segundos
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _buscarAlertas();
    });
  }


  Future<void> _buscarAlertas() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/newAlertas'),
        headers: {
          'Authorization': 'Bearer $_token', // Substitua pelo token real.
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Decodifica o JSON retornado pela API
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Acessa a lista de alertas dentro do campo "data"
        final List<dynamic> alertas = jsonResponse['data'] ?? [];

        setState(() {
          _notificacoes.clear();
          _notificacoes.addAll(alertas.map((alerta) {
            return {
              "descricao": (alerta["descricao"] ?? "Sem Descrição").toString(),
              "Gravidade": (alerta["tipo"] ?? "Desconhecida").toString(),
              "Data e hora": (alerta["data"] ?? "Data não disponível").toString(),
            };
          }).toList());
        });
      } else {
        print("Erro ao buscar alertas: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao buscar alertas: $e");
    }
  }

  void _marcarComoVisualizada(int index) {
    setState(() {
      _notificacoes[index]["descricao"] =
      "[Visualizada] ${_notificacoes[index]["descricao"]}";
    });
  }

  void _removerNotificacao(int index) {
    setState(() {
      _notificacoes.removeAt(index);
    });
  }

  void _removerTodasNotificacoes() {
    setState(() {
      _notificacoes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    _token = Provider.of<AllProvider>(context).token!;
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
                                for (var notificacao in _notificacoes) {
                                  notificacao["descricao"] =
                                      "[Visualizada] ${notificacao["descricao"]}";
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF41337A),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Visualizar todas",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: _removerTodasNotificacoes,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF41337A),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Remover todas",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          itemCount: _notificacoes.length,
                          itemBuilder: (context, index) {
                            return Card(
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
                                  _notificacoes[index]["titulo"]!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _notificacoes[index]["descricao"]!,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Data: ${_notificacoes[index]["data"]} - ${_notificacoes[index]["hora"]}",
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
                                      onPressed: () =>
                                          _marcarComoVisualizada(index),
                                      color: const Color(0xFF41337A),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () =>
                                          _removerNotificacao(index),
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
