import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final String? selectedPlaca;

  const HomeView({super.key, this.selectedPlaca});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late String placaInfo;
  late String temperatura;
  late String umidade;

  @override
  void initState() {
    super.initState();
    _atualizarInformacoes(widget.selectedPlaca);
  }

  @override
  void didUpdateWidget(HomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedPlaca != widget.selectedPlaca) {
      _atualizarInformacoes(widget.selectedPlaca);
    }
  }

  void _atualizarInformacoes(String? placa) {
    setState(() {
      if (placa == 'Placa 1') {
        placaInfo = 'Placa 1 - Localização: Estufa A';
        temperatura = 'Temperatura: 25ºC';
        umidade = 'Umidade: 60%';
      } else if (placa == 'Placa 2') {
        placaInfo = 'Placa 2 - Localização: Campo B';
        temperatura = 'Temperatura: 30ºC';
        umidade = 'Umidade: 50%';
      } else if (placa == 'Placa 3') {
        placaInfo = 'Placa 3 - Localização: Horta C';
        temperatura = 'Temperatura: 28ºC';
        umidade = 'Umidade: 55%';
      } else {
        placaInfo = 'Nenhuma placa selecionada';
        temperatura = 'Temperatura: --ºC';
        umidade = 'Umidade: --%';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFFF5F8DE), // Cor de fundo clara
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 934,
                      height: 695,
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
                          Text(
                            placaInfo,
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'OpenSans-Regular',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            temperatura,
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'OpenSans-Regular',
                            ),
                          ),
                          Text(
                            umidade,
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'OpenSans-Regular',
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
