import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solosmart_flutter/utils/provider.dart';
import 'package:solosmart_flutter/views/add_view.dart';
import 'package:solosmart_flutter/views/cadastro_view.dart';
import 'package:solosmart_flutter/views/config_view.dart';
import 'package:solosmart_flutter/views/dashborad_view.dart';
import 'package:solosmart_flutter/views/inicio_view.dart';
import 'package:solosmart_flutter/views/login_view.dart';
import 'package:solosmart_flutter/views/notif_view.dart';
import 'package:solosmart_flutter/views/perfil_view.dart';
import 'package:solosmart_flutter/views/recuperar_view.dart';
import 'package:solosmart_flutter/views/redefinir_view.dart';
import 'package:solosmart_flutter/views/relatorios_view.dart';
import 'package:solosmart_flutter/views/suport_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AllProvider()),
        ChangeNotifierProvider(
            create: (context) => ProfileImageProvider(
                context)) // Adicionar o ProfileImageProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SoloSmart',
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginView(),
        '/resetar': (context) => const ResetPasswordView(),
        '/dashboard': (context) => const DashboardView(),
        '/cadastro': (context) => const CadastroView(),
        '/perfil': (context) => const PerfilView(),
        '/configuração': (context) => const ConfigView(),
        '/adicionar': (context) => const AddView(),
        'notificações': (context) => const NotifView(),
        '/recuperar': (context) => const PasswordRecoveryView(),
        '/relatórios': (context) => const RelatoriosView(),
        '/home': (context) => const InicioView(),
      },
    );
  }
}
