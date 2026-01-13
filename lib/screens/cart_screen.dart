import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escutando as mudanças no carrinho
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items.values.toList(); // Converte o Map para List

    return Scaffold(
      backgroundColor: const Color(0xFF060410),
      appBar: AppBar(
        title: const Text(
          'MEU CARRINHO',
          style: TextStyle(letterSpacing: 2, fontWeight: .bold),
        ), // Text
        backgroundColor: const Color(0xFF1A0B2E),
      ), // AppBar
      body:  cart.itemCount == 0
    ? Center(
        child: Column(
          mainAxisAlignment: .center, // Shorthand
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Colors.white.withValues(alpha: 0.2), // Sem withOpacity
            ), // Icon
            const SizedBox(height: 20),
            const Text(
              'Seu carrinho está vazio!',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: .bold,
              ), // TextStyle
            ), // Text
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'VOLTAR PARA O CATÁLOGO',
                style: TextStyle(color: Colors.cyanAccent),
              ), // Text
            ), // TextButton
          ], // children
        ), // Column
      ) // Center
    :
      
      
      Column(
        children: [
          // Card de Totalizador Dinâmico
          Card(
            margin: const EdgeInsets.all(15),
            color: const Color(0xFF1A0B2E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
            ), // RoundedRectangleBorder
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ), // Text
                  const Spacer(),
                  Chip(
                    label: Text(
                      'R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFF060410),
                        fontWeight: .bold,
                      ), // TextStyle
                    ), // Text
                    backgroundColor: Colors.cyanAccent,
                  ), // Chip
                ], // children
              ), // Row
            ), // Padding
          ), // Card
          // Lista Real de Itens
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) => _CartItemWidget(cartItems[i]),
            ), // ListView.builder
          ), // Expanded
        ], // children
      ), // Column
    ); // Scaffold
  }
}

// Widget auxiliar para cada item do carrinho
class _CartItemWidget extends StatelessWidget {
  final CartItem item;
  const _CartItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: const Color(0xFF1A0B2E),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.cyanAccent,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: Text(
                '${item.quantity}x',
                style: const TextStyle(
                  color: Color(0xFF060410),
                  fontWeight: .bold,
                ),
              ), // Text
            ), // FittedBox
          ), // Padding
        ), // CircleAvatar
        title: Text(
          item.title,
          style: const TextStyle(color: Colors.white, fontWeight: .bold),
        ), // Text
        subtitle: Text(
          'R\$ ${(item.price * item.quantity).toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.white70),
        ), // Text
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: () {
            // Exibe um diálogo de confirmação (Boa prática de UX!)
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: const Color(0xFF1A0B2E),
                title: const Text(
                  'Remover Item',
                  style: TextStyle(color: Colors.white),
                ),
                content: const Text('Deseja retirar este produto do carrinho?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text(
                      'NÃO',
                      style: TextStyle(color: Colors.cyanAccent),
                    ),
                  ), // TextButton
                  TextButton(
                    onPressed: () {
                      // Chama a remoção no Provider usando o productId
                      Provider.of<Cart>(
                        context,
                        listen: false,
                      ).removeItem(item.productId);
                      Navigator.of(ctx).pop();
                    },
                    child: const Text(
                      'SIM',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ), // TextButton
                ], // actions
              ), // AlertDialog
            ); // showDialog
          },
        ), // IconButton,
      ), // ListTile
    ); // Card
  }
}
