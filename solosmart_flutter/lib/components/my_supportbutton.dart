import 'package:flutter/material.dart';

class MySupportButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MySupportButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(65, 51, 122, 1),
              shape: BoxShape.circle,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.headset_mic, color: Colors.white),
            iconSize: 40, // Tamanho do ícone
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
