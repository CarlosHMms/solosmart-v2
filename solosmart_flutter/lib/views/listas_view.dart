import 'package:flutter/material.dart';

class ListasView extends StatefulWidget {
  final void Function() onBackButtonPressed;

  const ListasView({super.key, required this.onBackButtonPressed});

  @override
  State<ListasView> createState() => _ListasViewState();
}

class _ListasViewState extends State<ListasView> {
  // Lista fictícia de tickets com detalhes
  List<Map<String, dynamic>> tickets = [
    {
      'title': 'Problema com login',
      'status': 'Aberto',
      'responses': [
        'Resposta 1: Verifique se o login está correto.',
        'Resposta 2: Tente redefinir a senha.'
      ]
    },
    {
      'title': 'Erro na página de pagamento',
      'status': 'Em progresso',
      'responses': ['Resposta 1: Problema com o servidor de pagamento.']
    },
    {
      'title': 'Solicitação de alteração de senha',
      'status': 'Fechado',
      'responses': ['Resposta 1: Senha alterada com sucesso.']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8DE),
      body: Center(
        child: Container(
          width: 900,
          height: 700,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F8DE),
            borderRadius: BorderRadius.circular(19),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(-7, 11),
                blurRadius: 25,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Minhas Solicitações',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ticket['title'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Status: ${ticket['status']}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    ticket['status'] == 'Fechado'
                                        ? Icons.check_circle
                                        : Icons.error,
                                    color: ticket['status'] == 'Fechado'
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Expansível com detalhes do ticket
                              ExpansionTile(
                                title: const Text(
                                  'Detalhes do Ticket',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                children: [
                                  for (var response in ticket['responses'])
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, bottom: 8.0),
                                      child: Text(
                                        response,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                ],
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
    );
  }
}
