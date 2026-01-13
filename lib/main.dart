import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo Premium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // ESTA É A CHAVE: Define a cor de fundo para TODAS as transições
        scaffoldBackgroundColor: const Color(0xFF060410),
        canvasColor: const Color(0xFF060410),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyanAccent,
          brightness: Brightness.dark, // Força o sistema a entender que o app é escuro
        ), // ColorScheme.fromSeed
      ), // ThemeData
      home: const HomeScreen(),
    ); // MaterialApp
  }
}