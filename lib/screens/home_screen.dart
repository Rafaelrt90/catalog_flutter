import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          // Gradiente linear entre roxo profundo e azul escuro
          gradient: LinearGradient(
            begin: .topLeft, // Shorthand
            end: .bottomRight, // Shorthand
            colors: [
              const Color(0xFF1A0B2E), // Roxo profundo
              const Color(0xFF060410), // Azul quase preto
            ],
          ), // LinearGradient
        ), // BoxDecoration
        child: Stack(
          children: [
            // Mantivemos apenas algumas linhas sutis para manter o ar tecnológico
            Positioned(
              top: 150,
              left: -20,
              child: Transform.rotate(
                angle: -0.2,
                child: Container(
                  width: 500,
                  height: 0.5,
                  color: Colors.white.withValues(alpha: 0.05),
                ), // Container
              ), // Transform.rotate
            ), // Positioned

            SafeArea(
              child: Column(
                crossAxisAlignment: .start, // Shorthand
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                    child: Column(
                      crossAxisAlignment: .start, // Shorthand
                      children: [
                        Text(
                          'CATÁLOGO',
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 12,
                            letterSpacing: 4,
                            fontWeight: .w600,
                          ), // TextStyle
                        ), // Text
                        SizedBox(height: 8),
                        Text(
                          'Coleção 2026',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: .bold,
                          ), // TextStyle
                        ), // Text
                      ],
                    ), // Column
                  ), // Padding
                  
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 30),
                      itemCount: dummyProducts.length,
                      itemBuilder: (ctx, index) {
                        return ProductItem(dummyProducts[index]);
                      },
                    ), // ListView.builder
                  ), // Expanded
                ],
              ), // Column
            ), // SafeArea
          ],
        ), // Stack
      ), // Container
    ); // Scaffold
  }
}