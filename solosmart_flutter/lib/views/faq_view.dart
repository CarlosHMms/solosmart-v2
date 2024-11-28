import 'package:flutter/material.dart';

class FAQView extends StatelessWidget {
  final Function()
      onTicketButtonPressed; // Função que será chamada quando o botão for pressionado
  final Function()
      onMinhasSolicitacoesPressed; // Função para o botão "Minhas Solicitações"

  const FAQView(
      {super.key,
      required this.onTicketButtonPressed,
      required this.onMinhasSolicitacoesPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8DE),
      body: Center(
        child: Container(
          width: 900,
          height: 600,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: const Text(
                    'Suporte ao Cliente',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Botão "Minhas Solicitações"
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed:
                        onMinhasSolicitacoesPressed, // Chama a função para mudar para "Minhas Solicitações"
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF41337A),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Minhas Solicitações',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Open Sans',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Perguntas Frequentes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: const [
                      FAQDropdown(
                        question: "Como faço para resetar minha senha?",
                        answer:
                            "Para resetar sua senha, clique em 'Esqueceu sua senha?' na página de login e siga as instruções enviadas para seu e-mail.",
                      ),
                      FAQDropdown(
                        question: "Como atualizo meus dados cadastrais?",
                        answer:
                            "Acesse a aba 'Configurações' no menu principal, e atualize as informações desejadas.",
                      ),
                      FAQDropdown(
                        question: "Qual o horário de funcionamento do suporte?",
                        answer:
                            "Nosso suporte funciona de segunda a sexta, das 9h às 18h.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Botão "Entre em Contato"
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed:
                        onTicketButtonPressed, // Chama a função para trocar para TicketView
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF41337A),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Entre em Contato',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Open Sans',
                        color: Colors.white,
                      ),
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

class FAQDropdown extends StatefulWidget {
  final String question;
  final String answer;

  const FAQDropdown({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FAQDropdown> createState() => _FAQDropdownState();
}

class _FAQDropdownState extends State<FAQDropdown> {
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          InkWell(
            onTap: toggleExpansion,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.answer,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
