import 'package:flutter/material.dart';
import 'package:solosmart_flutter/services/placaController.dart';
import 'package:http/http.dart' as http;

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  String _name = '';
  String _numeroSerie = '';
  final _formKey = GlobalKey<FormState>();
  final PlacaService _placaService = PlacaService();

  Future<void> _cadastrarPlaca() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      try {
        final http.Response response = await _placaService.cadastrarPlaca(
            _numeroSerie, 1); // UserId = 1 como exemplo

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Placa cadastrada com sucesso!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Erro ao cadastrar placa: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8DE),
      body: Center(
        child: Container(
          width: 612,
          height: 654,
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Cadastrar Central',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Open Sans',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                // Campo de Nome
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Nome',
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
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'Digite o nome',
                    ),
                    onSaved: (value) {
                      _name = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Campo de Número de Série
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Número de Série',
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
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: 'Digite o número de série',
                    ),
                    onSaved: (value) {
                      _numeroSerie = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o número de série';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                // Botão Cadastrar
                ElevatedButton(
                  onPressed:
                      _cadastrarPlaca, // Chama a função para cadastrar a placa
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF41337A),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 115,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Cadastrar',
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

  // Widget para os itens do menu
  Widget _menuItem(String title, IconData icon, double topPosition) {
    return Padding(
      padding: const EdgeInsets.only(left: 71.0, top: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Inter-Regular',
            ),
          ),
        ],
      ),
    );
  }
}
