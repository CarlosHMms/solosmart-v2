import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/services/ticketsService.dart';
import 'package:solosmart_flutter/utils/provider.dart';

class TicketView extends StatefulWidget {
  const TicketView({super.key});

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Ticketsservice _ticketsservice = Ticketsservice();
  bool isLoading = false; // Controla o estado do botão

  Future<void> _abrirTicket() async {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, preencha todos os campos.")),
      );
      return;
    }

    setState(() {
      isLoading = true; // Exibe o indicador de carregamento
    });

    try {
      final userProvider = Provider.of<AllProvider>(context, listen: false);
      int status = 1;
      final token = userProvider.token;
      final email = userProvider.email;
      final assunto = _titleController.text;
      final descricao = _descriptionController.text;

      final response = await _ticketsservice.ticket(
        token!,
        email!,
        status,
        assunto,
        descricao,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> tickets = json.decode(response.body)['data'];
        if (tickets != null) {
          Provider.of<AllProvider>(context, listen: false).setTickets(tickets);
        }

        // Exibe um diálogo de sucesso
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sucesso!'),
              content: const Text('Ticket enviado com sucesso!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );

        // Limpa os campos após o sucesso
        _titleController.clear();
        _descriptionController.clear();
      } else {
        throw Exception('Erro ao enviar ticket: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar ticket: $e')),
      );
    } finally {
      setState(() {
        isLoading = false; // Restaura o estado do botão
      });
    }
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enviar Ticket de Suporte',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Open Sans',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Título do Ticket',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'Digite o título do ticket',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Descrição do Problema',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'Descreva o problema',
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : _abrirTicket, // Desabilita enquanto carrega
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isLoading
                        ? Colors.grey
                        : const Color(
                            0xFF41337A), // Cor diferente durante o carregamento
                    padding: const EdgeInsets.symmetric(
                      horizontal: 115,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Enviar Ticket',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Open Sans',
                            color: Colors.white,
                          ),
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
