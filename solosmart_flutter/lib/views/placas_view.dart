import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/services/generateData.dart';
import 'package:solosmart_flutter/services/placaService.dart';
import 'package:solosmart_flutter/utils/provider.dart';
import 'dart:convert';

class PlacasView extends StatefulWidget {
  final VoidCallback onAddButtonPressed;
  final Function(int) onDashboardSelected;
  final ValueNotifier<String?> selectedPlacaNotifier;

  const PlacasView({
    super.key,
    required this.onAddButtonPressed,
    required this.onDashboardSelected,
    required this.selectedPlacaNotifier,
  });

  @override
  State<PlacasView> createState() => _PlacasViewState();
}

class _PlacasViewState extends State<PlacasView> {
  final PlacaService _placaController = PlacaService();
  final Generatedata _generatedata = Generatedata();
  final TextEditingController _nameController = TextEditingController();
  int? _editingPlacaId;
  String? token;
  List<dynamic> _placas = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      token = Provider.of<AllProvider>(context, listen: false).token;
      if (token != null) {
        _carregarPlacas();
      }
    });
  }

  Future<void> _carregarPlacas() async {
    try {
      final response = await _placaController.listarPlaca(token!);

      if (response.statusCode == 200) {
        List<dynamic> placasJson = json.decode(response.body)['data'];
        setState(() {
          _placas = placasJson;
        });
      } else {
        throw Exception('Erro ao carregar as placas: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar as placas: $e');
    }
  }

  Future<void> _buscarDados(int placaId) async {
    try {
      final response = await _generatedata.buscarDados(placaId, token!);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        Map<String, dynamic>? dados = responseData['data'];
        if (dados != null) {
          Provider.of<AllProvider>(context, listen: false).setDados(dados);
        }
        print('Dados buscado com sucesso para a placa $placaId.');
        widget.onDashboardSelected(1);
      } else {
          final response = await _generatedata.gerarDados(placaId, token!);
          if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          Map<String, dynamic>? dados = responseData['data'];
          if (dados != null) {
            Provider.of<AllProvider>(context, listen: false).setDados(dados);
          }
        }
        widget.onDashboardSelected(1);
      }
    } catch (e) {
      print('Erro ao buscar dados: $e');
    }
  }

  Future<void> _deletar(int placaId) async{
    try{
      final response = await _placaController.removerPlaca(token!, placaId);

      if (response.statusCode == 200) {
        print(response.body);
      
      } else {
        print("Erro ao excluir a placa: ${response.body}");
      }
    }catch (e){
      print('Erro ao deletar placa: $e');
    }
  }

  Future<void> _editarPlaca(int placaId) async {
    try {
      final response = await _placaController.editPlaca(
          token!, placaId, _nameController.text);
      if (response.statusCode == 200) {
        print('Placa editada com sucesso');
        setState(() {
          _editingPlacaId = null;
        });
        _carregarPlacas();
      } else {
        throw Exception('Erro ao editar a placa: ${response.body}');
      }
    } catch (e) {
      print('Erro ao editar placa: $e');
    }
  }

  void _onPlacaSelecionada(String placaName, int placaId) {
    print('Placa selecionada: $placaName');
    widget.selectedPlacaNotifier.value = placaName;
    Provider.of<AllProvider>(context, listen: false).setPlacaId(placaId);
    _buscarDados(placaId);
  }

  Widget _buildPlacaItem(Map<String, dynamic> placa) {
    int placaId = placa['id'];
    String placaName = placa['name'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _onPlacaSelecionada(placaName, placaId),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(65, 51, 122, 1),
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              minimumSize: const Size(150, 0),
            ),
            child: Text(
              placaName,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          _editingPlacaId == placaId
              ? Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(hintText: 'Novo nome'),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _editarPlaca(placaId),
                      icon: const Icon(Icons.check, color: Colors.green),
                    ),
                  ],
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      _editingPlacaId = placaId;
                      _nameController.text = placaName;
                    });
                  },
                  icon: const Icon(Icons.edit, color: Color(0xFF41337A)),
                ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _confirmarExclusao(placaId),
          ),
        ],
      ),
    );
  }

  void _confirmarExclusao(int placaId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar exclusão"),
          content: const Text("Tem certeza de que deseja excluir esta placa?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                await _deletar(placaId);
                Navigator.of(context).pop();
              },
              child: const Text("Excluir"),
            ),
          ],
        );
      },
    );
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
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Selecionar Central',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _placas.isEmpty
                            ? const Center(
                                child: Text(
                                  'Não há placas adicionadas.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                itemCount: _placas.length,
                                itemBuilder: (context, index) {
                                  return _buildPlacaItem(_placas[index]);
                                },
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
