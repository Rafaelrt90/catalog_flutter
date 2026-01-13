import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1; // Estado para a quantidade

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xFF060410),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ), // AppBar
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: .topLeft,
            end: .bottomRight,
            colors: [const Color(0xFF1A0B2E), const Color(0xFF060410)],
          ), // LinearGradient
        ), // BoxDecoration
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Área da Imagem com Hero
              Hero(
                tag: widget.product.id,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.product.imageUrl),
                        fit: .cover,
                      ), // DecorationImage
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ), // BorderRadius
                    ), // BoxDecoration
                  ), // Container
                ), // Material
              ), // Hero

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: .bold,
                            ), // TextStyle
                          ), // Text
                        ), // Expanded
                        Text(
                          'R\$ ${widget.product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: const TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 22,
                            fontWeight: .w900,
                          ), // TextStyle
                        ), // Text
                      ],
                    ), // Row

                    const SizedBox(height: 25),

                    // Seletor de Quantidade Estilo Glass
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        const Text(
                          'QUANTIDADE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            letterSpacing: 2,
                            fontWeight: .bold,
                          ), // TextStyle
                        ), // Text
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                            ), // Border.all
                          ), // BoxDecoration
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (_quantity > 1) {
                                    setState(() => _quantity--);
                                  }
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.cyanAccent,
                                ),
                              ), // IconButton
                              Text(
                                '$_quantity',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: .bold,
                                ), // TextStyle
                              ), // Text
                              IconButton(
                                onPressed: () {
                                  setState(() => _quantity++);
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.cyanAccent,
                                ),
                              ), // IconButton
                            ],
                          ), // Row
                        ), // Container
                      ],
                    ), // Row

                    const SizedBox(height: 25),

                    Text(
                      'DESCRIÇÃO',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12,
                        letterSpacing: 2,
                        fontWeight: .bold,
                      ), // TextStyle
                    ), // Text

                    const SizedBox(height: 10),

                    Text(
                      widget.product.description,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 16,
                        height: 1.5,
                      ), // TextStyle
                    ), // Text

                    // Espaçamento final para o conteúdo não ficar escondido atrás do botão fixo
                    const SizedBox(height: 120),
                  ],
                ), // Column
              ), // Padding
            ],
          ), // Column
        ), // SingleChildScrollView
      ), // Container

      // BOTÃO FIXO NO RODAPÉ
      bottomNavigationBar: Container(
        color: const Color(0xFF060410), // Mantém o fundo escuro para não quebrar o gradiente
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 30),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                Colors.cyanAccent.withValues(alpha: 0.8),
                Colors.blueAccent.withValues(alpha: 0.8),
              ],
            ), // LinearGradient
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ), // BoxShadow
            ],
          ), // BoxDecoration
          child: ElevatedButton(
            onPressed: () {
  // Ajustado para passar o objeto product e a quantidade do estado (_quantity)
  cart.addItem(widget.product, _quantity); 
  
  ScaffoldMessenger.of(context).removeCurrentSnackBar(); // Limpa snacks anteriores

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '$_quantity x ${widget.product.title} no carrinho',
        style: const TextStyle(
          color: Color(0xFF060410),
          fontWeight: .bold,
        ), // TextStyle
      ), // Text
      backgroundColor: Colors.cyanAccent,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ), // RoundedRectangleBorder
      duration: const Duration(seconds: 2),
    ), // SnackBar
  ); // showSnackBar
},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ), // RoundedRectangleBorder
            ), // ElevatedButton.styleFrom
            child: const Text(
              'ADICIONAR AO CARRINHO',
              style: TextStyle(
                color: Color(0xFF060410),
                fontWeight: .w900,
                letterSpacing: 1.2,
              ), // TextStyle
            ), // Text
          ), // ElevatedButton
        ), // Container interno (Estilizado)
      ), // Container externo (Posicionamento)
    ); // Scaffold
  }
}