
import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../widgets/product_item.dart';
import 'cart_screen.dart'; // Importe a tela que criamos

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O FloatingActionButton fica aqui, como você começou a fazer
      floatingActionButton: Stack(
  alignment: .center, // Shorthand
  children: [
    // Botão Principal
    FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => const CartScreen()),
        ); // MaterialPageRoute
      },
      backgroundColor: Colors.cyanAccent,
      child: const Icon(
        Icons.shopping_cart,
        color: Color(0xFF060410),
      ), // Icon
    ), // FloatingActionButton
    
    // O Badge (Círculo com o contador)
    Positioned(
      right: 0,
      top: 0,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF060410),
            width: 1.5,
          ), // Border.all
        ), // BoxDecoration
        constraints: const BoxConstraints(
          minWidth: 18,
          minHeight: 18,
        ), // BoxConstraints
        child: const Text(
          '2', // Aqui depois colocaremos: cart.itemCount.toString()
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: .bold,
          ), // TextStyle
          textAlign: .center, // Shorthand
        ), // Text
      ), // Container
    ), // Positioned
  ], // children
), // Stack
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: .topLeft, // Shorthand
            end: .bottomRight, // Shorthand
            colors: [
              const Color(0xFF1A0B2E),
              const Color(0xFF060410),
            ],
          ), // LinearGradient
        ), // BoxDecoration
        child: Stack(
          children: [
            // Linhas decorativas tecnológicas
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
                      ], // children
                    ), // Column
                  ), // Padding
                  
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 30),
                      itemCount: dummyProducts.length,
                      itemBuilder: (ctx, index) {
                        return ProductItem(dummyProducts[index]);
                      }, // itemBuilder
                    ), // ListView.builder
                  ), // Expanded
                ], // children
              ), // Column
            ), // SafeArea
          ], // children
        ), // Stack
      ), // Container
    ); // Scaffold
  }
}