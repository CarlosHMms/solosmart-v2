import 'package:flutter/material.dart';

class NotifView extends StatefulWidget {
  const NotifView({super.key});

  @override
  State<NotifView> createState() => _NotifViewState();
}

class _NotifViewState extends State<NotifView> {
  List<Map<String, String>> _notificacoes = [
    {
      "titulo": "Sensor 1",
      "descricao": "Alerta de umidade alta",
      "data": "08/11/2024",
      "hora": "14:30"
    },
    {
      "titulo": "Sensor 2",
      "descricao": "Temperatura acima do limite",
      "data": "08/11/2024",
      "hora": "12:45"
    },
    {
      "titulo": "Sistema",
      "descricao": "Manutenção programada para amanhã",
      "data": "07/11/2024",
      "hora": "09:15"
    },
    {
      "titulo": "Notificação de atualização",
      "descricao": "Nova versão disponível",
      "data": "06/11/2024",
      "hora": "18:00"
    },
  ];

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
                            onPressed: _removerTodasNotificacoes,
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
