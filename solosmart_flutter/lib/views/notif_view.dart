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
  final List<Map<String, dynamic>> _notificacoes =
      []; // Alerta recebe tipo dinâmico
  late Timer _pollingTimer;

  @override
  void initState() {
    super.initState();
    _buscarAlertas();
    //_iniciarPolling(); // Inicia o polling assim que a tela é criada
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
      final userProvider = Provider.of<AllProvider>(context, listen: false);
      final token = userProvider.token;

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/newAlertas'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> alertas = jsonResponse['data'] ?? [];

        // Atualiza a lista de notificações
        if (mounted) {
          setState(() {
            _notificacoes.clear();
            _notificacoes.addAll(alertas.map((alerta) {
              return {
                "id": alerta["id"],
                "tipo": alerta["tipo"] ?? "Sem Tipo",
                "descricao": alerta["descricao"] ?? "Sem Descrição",
                "dataHora": alerta["data"] ?? "Data não disponível",
                "visualizada": false, // Novo campo
              };
            }).toList());
          });
        }
      } else {
        print("Erro ao buscar alertas: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao buscar alertas: $e");
    }
  }

  Future<void> marcarAlertasComoVisualizados(List<int> ids) async {
    final token = Provider.of<AllProvider>(context, listen: false).token;

    try {
      final response = await http.put(
        Uri.parse('http://127.0.0.1:8000/api/alertas/visualizar'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'ids': ids}),
      );

      if (response.statusCode == 200) {
        setState(() {
          for (var notificacao in _notificacoes) {
            notificacao["visualizada"] = true;
            notificacao["descricao"] =
                "[Visualizada] ${notificacao["descricao"]}";
          }
        });
        print('Alertas marcados como visualizados com sucesso.');
      } else {
        print('Erro ao atualizar alertas: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao atualizar alertas: $e');
    }
  }


  Future<void> _marcarComoVisualizada(int index) async {
    final token = Provider.of<AllProvider>(context, listen: false).token;

    try {
      final idAlerta = _notificacoes[index]['id'];

      final response = await http.put(
        Uri.parse('http://127.0.0.1:8000/api/alertas/visualizar'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'ids': [idAlerta]
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _notificacoes[index]["visualizada"] = true;
          _notificacoes[index]["descricao"] =
              "[Visualizada] ${_notificacoes[index]["descricao"]}";
        });
      } else {
        debugPrint('Erro ao marcar alerta como visualizado: ${response.body}');
      }
    } catch (e) {
      debugPrint('Erro ao marcar alerta como visualizado: $e');
    }
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
                              final ids = _notificacoes
                                  .map(
                                      (notificacao) => notificacao["id"] as int)
                                  .toList();
                              marcarAlertasComoVisualizados(ids);
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
                            // Determina a cor do Card com base no tipo do alerta
                            Color cardColor;
                            switch (_notificacoes[index]["tipo"]) {
                              case "leve":
                                cardColor = Colors
                                    .green.shade100; // Verde para tipo leve
                                break;
                              case "medio":
                                cardColor = Colors
                                    .yellow.shade100; // Amarelo para tipo médio
                                break;
                              case "grave":
                                cardColor = Colors
                                    .red.shade100; // Vermelho para tipo grave
                                break;
                              default:
                                cardColor = Colors.grey.shade200; // Cor padrão
                            }

                            return Card(
                              color: cardColor, // Define a cor do Card
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 2,
                              child: ListTile(
                                leading: Icon(
                                  Icons.notification_important,
                                  color: _notificacoes[index]["tipo"] == "leve"
                                      ? Colors.green
                                      : _notificacoes[index]["tipo"] == "medio"
                                          ? Colors.yellow[800]
                                          : Colors.red,
                                ),
                                title: Text(
                                  _notificacoes[index]["descricao"],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "Data/Hora: ${_notificacoes[index]["dataHora"]}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: _notificacoes[index]
                                                ["visualizada"]
                                            ? Colors
                                                .grey // Cinza se visualizada
                                            : const Color(0xFF41337A),
                                      ),
                                      onPressed: _notificacoes[index]
                                              ["visualizada"]
                                          ? null // Desativa o botão
                                          : () => _marcarComoVisualizada(index),
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
