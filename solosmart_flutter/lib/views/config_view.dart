import 'package:flutter/material.dart';

class ConfigView extends StatefulWidget {
  const ConfigView({super.key});

  @override
  State<ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {
  bool isManual = true; // Estado do checkbox para modo manual/automático
  bool isOn = false; // Estado do botão Ligar/Desligar
  double humidityLevel = 50; // Nível de umidade inicial

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Painel principal
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Configurações',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'OpenSans-SemiBold',
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Botão Manual
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: isManual,
                                          onChanged: (value) {
                                            setState(() {
                                              isManual = true;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Manual',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'OpenSans-Regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    // Botão Ligar/Desligar abaixo de Manual
                                    ElevatedButton(
                                      onPressed: isManual
                                          ? () {
                                              setState(() {
                                                isOn = !isOn;
                                              });
                                            }
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            isOn ? Colors.green : Colors.red,
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
                                const SizedBox(width: 20),
                                // Botão Automático
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: !isManual,
                                          onChanged: (value) {
                                            setState(() {
                                              isManual = false;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Automático',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'OpenSans-Regular',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    // Slider de nível de umidade (ativo apenas no modo automático)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
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
                                          onChanged: isManual
                                              ? null
                                              : (value) {
                                                  setState(() {
                                                    humidityLevel = value;
                                                  });
                                                },
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
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
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            // Card Temporizador
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Temporizador',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans-Regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Defina o tempo (min)',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ],
                                ),
                              ),
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
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Salvar Configurações',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
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
