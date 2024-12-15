import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/services/ticketService.dart';
import 'package:solosmart_flutter/utils/provider.dart';

class ListasView extends StatefulWidget {
  final void Function() onBackButtonPressed;

  const ListasView({super.key, required this.onBackButtonPressed});

  @override
  State<ListasView> createState() => _ListasViewState();
}

class _ListasViewState extends State<ListasView> {
  final Ticketsservice _ticketsController = Ticketsservice();
  String? token;
  List<dynamic> _tickets = [];

  Future<void> _carregarTickets() async {
    token = Provider.of<AllProvider>(context, listen: false).token;
    try {
      final response = await _ticketsController.listarTickets(token!);

      if (response.statusCode == 200) {
        List<dynamic> ticketsJson = json.decode(response.body)['data'];
        setState(() {
          _tickets = ticketsJson;
        });
      } else {
        throw Exception('Erro ao carregar os tickets: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar os tickets: $e');
    }
  }

  String _statusTexto(int status) {
    switch (status) {
      case 0:
        return 'Fechado';
      case 1:
        return 'Em Andamento';
      default:
        return 'Desconhecido';
    }
  }

  Color _statusCor(int status) {
    switch (status) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarTickets();
  }

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
                    itemCount: _tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = _tickets[index];
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
                                        ticket['assunto'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Status: ${_statusTexto(ticket['status'])}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    ticket['status'] == 0
                                        ? Icons.check_circle
                                        : Icons.error,
                                    color: _statusCor(ticket['status']),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, bottom: 8.0),
                                    child: Text(
                                      'Descrição: ${ticket['descricao']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, bottom: 8.0),
                                    child: Text(
                                      'Data do Ticket: ${ticket['data_ticket']}',
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
