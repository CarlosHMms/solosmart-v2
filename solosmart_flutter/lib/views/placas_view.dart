import 'package:flutter/material.dart';

class PlacasView extends StatefulWidget {
  final VoidCallback onAddButtonPressed;

  const PlacasView({super.key, required this.onAddButtonPressed});

  @override
  State<PlacasView> createState() => _PlacasViewState();
}

class _PlacasViewState extends State<PlacasView> {
  List<String> placas = ['Placa 1', 'Placa 2', 'Placa 3'];

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
                            child: placas.isNotEmpty
                                ? ListView.builder(
                                    padding: const EdgeInsets.all(16.0),
                                    itemCount: placas.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          placas[index],
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
