import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart'; // Vamos criar este arquivo

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: InkWell(
            onTap: () {
              // Navegação para a tela de detalhes
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ProductDetailScreen(product: product),
                ), // MaterialPageRoute
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.cyan.withValues(alpha: 0.3),
                  width: 1.5,
                ), // Border.all
              ), // BoxDecoration
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Hero(
                      tag: product.id, // Chave única para a animação
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          product.imageUrl,
                          width: 90,
                          height: 90,
                          fit: .cover,
                        ), // Image.network
                      ), // ClipRRect
                    ), // Hero
                  ), // Padding
                  Expanded(
                    child: Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: .bold,
                          ), // TextStyle
                        ), // Text
                        const SizedBox(height: 5),
                        Text(
                          product.description,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 12,
                          ), // TextStyle
                          maxLines: 2,
                          overflow: .ellipsis,
                        ), // Text
                      ],
                    ), // Column
                  ), // Expanded
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'R\$ ${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: const TextStyle(
                        color: Colors.cyanAccent,
                        fontWeight: .w900,
                        fontSize: 16,
                      ), // TextStyle
                    ), // Text
                  ), // Padding
                ],
              ), // Row
            ), // Container
          ), // InkWell
        ), // BackdropFilter
      ), // ClipRRect
    ); // Padding
  }
}