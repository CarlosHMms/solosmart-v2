import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/services/placaService.dart';
import 'package:solosmart_flutter/utils/provider.dart';
import 'dart:convert';

class PlacasView extends StatefulWidget {
  final VoidCallback onAddButtonPressed;

  const PlacasView({super.key, required this.onAddButtonPressed});

  @override
  State<PlacasView> createState() => _PlacasViewState();
}

class _PlacasViewState extends State<PlacasView> {
  final PlacaService _placaController = PlacaService();
  String? token;
  List<dynamic> _placas = []; // Lista dinâmica para armazenar as placas

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    token = Provider.of<AllProvider>(context).token;

    if (token != null) {
      _carregarPlacas(); // Chama a função para carregar as placas ao inicializar a tela
    }
  }

  Future<void> _carregarPlacas() async {
    try {
      final response = await _placaController.listarPlaca(token!);

      if (response.statusCode == 200) {
        // Decodifica o JSON e atualiza o estado com a lista de placas
        List<dynamic> placasJson = json.decode(response.body)['data'];
        setState(() {
          _placas = placasJson;
        });
      } else {
        throw Exception('Erro ao carregar as placas: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar as placas: $e');
      // Aqui você pode exibir um erro na interface
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
                  width: 450,
                  height: 500,
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
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 50.0),
                            child: Text(
                              'Selecionar Central',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Open Sans',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: _placas.isNotEmpty
                                ? ListView.builder(
                                    padding: const EdgeInsets.all(16.0),
                                    itemCount: _placas.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          _placas[index]['name'],
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text(
                                      'Não há placas adicionadas',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 60,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: InkWell(
                            onTap: widget.onAddButtonPressed,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(65, 51, 122, 1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
