import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigView extends StatefulWidget {
  const ConfigView({super.key});

  @override
  State<ConfigView> createState() => _ConfigViewState();
}

enum Modo { manual, automatico, temporizador }

class _ConfigViewState extends State<ConfigView> {
  Modo modoPlaca = Modo.manual; // Estado do checkbox para modo manual/automático/temporizador


  bool isOn = false; // Estado do botão Ligar/Desligar
  double humidityLevel = 50; // Nível de umidade inicial

  // Função para interpolar a cor com base no valor de umidade
  Color getHumidityColor(double humidity) {
    // Definir as cores base para os intervalos de umidade
    Color low = Colors.red; // Cor para baixa umidade (0%)
    Color medium = Colors.orange; // Cor para umidade intermediária (~50%)
    Color high = Colors.blue; // Cor para alta umidade (~100%)

    if (humidity <= 50) {
      // Interpolando entre vermelho e laranja
      return Color.lerp(low, medium, humidity / 50)!;
    } else {
      // Interpolando entre laranja e verde
      return Color.lerp(medium, high, (humidity - 50) / 50)!;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8DE),
      body: Center(
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Título Configurações
                const Text(
                  'Configurações',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'OpenSans-SemiBold',
                  ),
                ),
                const SizedBox(height: 20),

                // Row principal para os três elementos (Manual, Automático e Temporizador)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container para Modo Manual
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Center(
                             child:Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: modoPlaca == Modo.manual,
                                    onChanged: (value) {
                                      setState(() {
                                        modoPlaca = Modo.manual;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Manual',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans-Regular',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: modoPlaca == Modo.manual
                                  ? () {
                                setState(() {
                                  isOn = !isOn;
                                });
                              }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isOn ? Colors.green : Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              child: Text(
                                isOn ? 'Desligar' : 'Ligar',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Container para Modo Automático
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: modoPlaca == Modo.automatico,
                                      onChanged: (value) {
                                        setState(() {
                                          modoPlaca = Modo.automatico;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Automático',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans-Regular',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 10),
                            const Text(
                              'Nível de Umidade',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'OpenSans-Regular',
                              ),
                            ),
                            Slider(
                              value: humidityLevel,
                              min: 0,
                              max: 100,
                              divisions: 100,
                              label: '${humidityLevel.round()}%',
                              onChanged: modoPlaca == Modo.automatico
                                  ? null
                                  : (value) {
                                setState(() {
                                  humidityLevel = value;
                                });
                              },
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '+Baixa',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'OpenSans-Regular',
                                  ),
                                ),
                                Text(
                                  '+Alta',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'OpenSans-Regular',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Container para Temporizador
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: modoPlaca == Modo.temporizador,
                                    onChanged: (value) {
                                      setState(() {
                                        modoPlaca = Modo.temporizador;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Temporizador',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans-Regular',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Picker para horas
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text('Horas'),
                                      CupertinoPicker(
                                        itemExtent: 32.0,
                                        onSelectedItemChanged: (int index) {
                                          // Atualize a variável de horas aqui
                                        },
                                        children: List<Widget>.generate(25, (int index) {
                                          return Center(child: Text('$index'));
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                                // Picker para minutos
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text('Minutos'),
                                      CupertinoPicker(
                                        itemExtent: 32.0,
                                        onSelectedItemChanged: (int index) {
                                          // Atualize a variável de minutos aqui
                                        },
                                        children: List<Widget>.generate(61, (int index) {
                                          return Center(child: Text('$index'));
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                                // Picker para segundos
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text('Segundos'),
                                      CupertinoPicker(
                                        itemExtent: 32.0,
                                        onSelectedItemChanged: (int index) {
                                          // Atualize a variável de segundos aqui
                                        },
                                        children: List<Widget>.generate(61, (int index) {
                                          return Center(child: Text('$index'));
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Botão Salvar Configurações
                ElevatedButton(
                  onPressed: () {
                    // Lógica para salvar configurações
                  },
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
                    'Salvar Configurações',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Open Sans',
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
