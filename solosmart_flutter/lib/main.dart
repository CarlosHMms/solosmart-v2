import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/utils/provider.dart';
import 'package:solosmart_flutter/views/inicio_view.dart';
import 'package:solosmart_flutter/views/login_view.dart';
import 'package:solosmart_flutter/views/redefinir_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AllProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SoloSmart',
      theme: ThemeData(),
      //home: const LoginView(),
      routes: {
        '/': (context) => const LoginView(),
        '/reset': (context) => ResetPasswordView(),
      },
    );
  }
}
