import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Não esqueça do import!
import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  // FUNÇÃO PARA ENVIAR WHATSAPP
  void _sendToWhatsApp(BuildContext context, Cart cart) async {
    const String phoneNumber = "5511958655976"; // Coloque seu número com DDD
    
    String message = "🚀 *Novo Pedido - App Neon*\n\n";
    for (var item in cart.items.values) {
      message += "✅ ${item.quantity}x ${item.title} - R\$ ${(item.price * item.quantity).toStringAsFixed(2).replaceAll('.', ',')}\n";
    }
    message += "\n💰 *Total: R\$ ${cart.totalAmount.toStringAsFixed(2).replaceAll('.', ',')}*";
    
    final Uri whatsappUrl = Uri.parse(
      "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}"
    );

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Não foi possível abrir o WhatsApp")),
      ); // SnackBar
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      backgroundColor: const Color(0xFF060410),
      appBar: AppBar(
        title: const Text(
          'MEU CARRINHO',
          style: TextStyle(letterSpacing: 2, fontWeight: .bold),
        ), // Text
        backgroundColor: const Color(0xFF1A0B2E),
      ), // AppBar

      body: cart.itemCount == 0
          ? Center(
              child: Column(
                mainAxisAlignment: .center, // Shorthand
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.white.withValues(alpha: 0.2),
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
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) => _CartItemWidget(cartItems[i]),
            ), // ListView.builder

      // BOTÃO FIXO DE FINALIZAÇÃO
      bottomNavigationBar: cart.itemCount == 0
          ? null
          : Container(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 35),
              decoration: BoxDecoration(
                color: const Color(0xFF1A0B2E),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ), // BoxShadow
                ], // boxShadow
              ), // BoxDecoration
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      const Text(
                        'Total do Pedido',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ), // Text
                      Text(
                        'R\$ ${cart.totalAmount.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: const TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 22,
                          fontWeight: .bold,
                        ), // TextStyle
                      ), // Text
                    ],
                  ), // Row
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () => _sendToWhatsApp(context, cart),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00E676), Color(0xFF1DE9B6)],
                        ), // LinearGradient
                      ), // BoxDecoration
                      child: const Row(
                        mainAxisAlignment: .center,
                        children: [
                          Icon(Icons.message, color: Color(0xFF060410)),
                          SizedBox(width: 10),
                          Text(
                            'FINALIZAR VIA WHATSAPP',
                            style: TextStyle(
                              color: Color(0xFF060410),
                              fontWeight: .w900,
                              letterSpacing: 1.1,
                            ), // TextStyle
                          ), // Text
                        ],
                      ), // Row
                    ), // Container
                  ), // GestureDetector
                ],
              ), // Column
            ), // Container
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
                ), // TextStyle
              ), // Text
            ), // FittedBox
          ), // Padding
        ), // CircleAvatar
        title: Text(
          item.title,
          style: const TextStyle(color: Colors.white, fontWeight: .bold),
        ), // Text
        subtitle: Text(
          'R\$ ${(item.price * item.quantity).toStringAsFixed(2).replaceAll('.', ',')}',
          style: const TextStyle(color: Colors.white70),
        ), // Text
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: const Color(0xFF1A0B2E),
                title: const Text('Remover Item', style: TextStyle(color: Colors.white)),
                content: const Text('Deseja retirar este produto do carrinho?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('NÃO', style: TextStyle(color: Colors.cyanAccent)),
                  ), // TextButton
                  TextButton(
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false).removeItem(item.productId);
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('SIM', style: TextStyle(color: Colors.redAccent)),
                  ), // TextButton
                ], // actions
              ), // AlertDialog
            ); // showDialog
          },
        ), // IconButton
      ), // ListTile
    ); // Card
  }
}