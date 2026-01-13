import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import essencial
import 'screens/home_screen.dart';
import './providers/cart.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => Cart(),
      child: const MyApp(),
    ), // ChangeNotifierProvider
  );
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
        scaffoldBackgroundColor: const Color(0xFF060410),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyanAccent,
          brightness: .dark, // Shorthand
        ), // ColorScheme.fromSeed
      ), // ThemeData
      home: const HomeScreen(), 
    ); // MaterialApp
  }
}