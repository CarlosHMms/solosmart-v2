import 'package:flutter/material.dart';

class PlacasView extends StatefulWidget {
  final VoidCallback onAddButtonPressed;

  const PlacasView({super.key, required this.onAddButtonPressed});

  @override
  State<PlacasView> createState() => _PlacasViewState();
}

class _PlacasViewState extends State<PlacasView> {
  List<String> placas = ['Placa 1'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFFF5F8DE),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 600,
                      height: 400,
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
                          placas.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                    itemCount: placas.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(placas[index]),
                                      );
                                    },
                                  ),
                                )
                              : const Text(
                                  'Não há placas adicionadas',
                                  style: TextStyle(fontSize: 18),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ElevatedButton(
                              onPressed: widget.onAddButtonPressed,
                              child: const Text(
                                "+ Adicionar Placa",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
