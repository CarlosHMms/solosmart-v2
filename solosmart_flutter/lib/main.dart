import 'package:flutter/material.dart';
import 'package:solosmart_flutter/views/inicio_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoloSmart',
      theme: ThemeData(
      ),
      home: const InicioView(),
    );
  }
}
