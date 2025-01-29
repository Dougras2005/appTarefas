import 'package:app_gerenciamento_de_tarefas/presentation/pages/cadastro_page.dart';
import 'package:app_gerenciamento_de_tarefas/presentation/pages/home_Page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/CadastroTarefa': (context) =>
        const CadastroTarefa(), // Adicione a página de cadastro de tarefas

      },
    );
  }
}

