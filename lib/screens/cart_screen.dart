import 'package:flutter/material.dart';
import '../models/product.dart'; // Importando seu model

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060410),
      appBar: AppBar(
        title: const Text(
          'MEU CARRINHO',
          style: TextStyle(letterSpacing: 2, fontWeight: .bold),
        ), // Text
        backgroundColor: const Color(0xFF1A0B2E),
        iconTheme: const IconThemeData(color: Colors.white),
      ), // AppBar
      body: Column(
        children: [
          // Card de Totalizador
          Card(
            margin: const EdgeInsets.all(15),
            color: const Color(0xFF1A0B2E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
            ), // RoundedRectangleBorder
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ), // Text
                  const Spacer(),
                  Chip(
                    label: const Text(
                      'R\$ 150,00', // Aqui depois entrará a lógica do Provider
                      style: TextStyle(color: Color(0xFF060410), fontWeight: .bold),
                    ), // Text
                    backgroundColor: Colors.cyanAccent,
                  ), // Chip
                  TextButton(
                    onPressed: () {
                      // Lógica de checkout
                    },
                    child: const Text(
                      'COMPRAR',
                      style: TextStyle(color: Colors.cyanAccent, fontWeight: .w900),
                    ), // Text
                  ), // TextButton
                ], // children
              ), // Row
            ), // Padding
          ), // Card
          
          const SizedBox(height: 10),
          
          // Lista de Itens do Carrinho
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Mock de exemplo
              itemBuilder: (ctx, i) => _buildCartItem(),
            ), // ListView.builder
          ), // Expanded
        ], // children
      ), // Column
    ); // Scaffold
  }

  Widget _buildCartItem() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: const Color(0xFF1A0B2E).withValues(alpha: 0.5),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.cyanAccent,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child: Text('1x', style: TextStyle(color: Color(0xFF060410))),
            ), // FittedBox
          ), // Padding
        ), // CircleAvatar
        title: const Text(
          'Produto Exemplo',
          style: TextStyle(color: Colors.white, fontWeight: .bold),
        ), // Text
        subtitle: const Text(
          'Total: R\$ 50,00',
          style: TextStyle(color: Colors.white70),
        ), // Text
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () {
            // Lógica para remover item
          },
        ), // IconButton
      ), // ListTile
    ); // Card
  }
}