import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/utils/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final dadosProvider = Provider.of<AllProvider>(context);
    final dados = dadosProvider.dados;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFFF5F8DE),
              child: Stack(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Container(
                        width: 934,
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
                            const SizedBox(height: 100),
                            // Temperatura Atual
                            _buildDashboardCard(
                              context,
                              title: 'Temperatura Atual',
                              value:
                                  '${dados?['temperatura_ar']?.toString() ?? 'N/A'} °C',
                              icon: Icons.thermostat_outlined,
                              color: Colors.orangeAccent,
                            ),
                            const SizedBox(height: 100),
                            // Umidade do Ar
                            _buildDashboardCard(
                              context,
                              title: 'Umidade do Ar',
                              value: 
                                '${dados?['umidade_ar']?.toString() ?? 'N/A'} %',
                              icon: Icons.water_drop_outlined,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(height: 100),
                            // Umidade do Solo
                            _buildDashboardCard(
                              context,
                              title: 'Umidade do Solo',
                              value:
                                '${dados?['umidade_solo']?.toString() ?? 'N/A'} %',
                              icon: Icons.grass_outlined,
                              color: Colors.greenAccent,
                            ),
                            const SizedBox(height: 100),
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

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 300,
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
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
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
