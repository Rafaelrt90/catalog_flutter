import 'package:flutter/material.dart';
import '../models/product.dart';

// Classe que representa um item dentro do carrinho
class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  }); // CartItem
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product, int quantity) {
    if (_items.containsKey(product.id)) {
      // Se já existe, apenas aumenta a quantidade
      _items.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity + quantity,
        ),
      ); // update
    } else {
      // Se não existe, adiciona novo
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: DateTime.now().toString(),
          productId: product.id,
          title: product.title,
          price: product.price,
          quantity: quantity,
        ),
      ); // putIfAbsent
    }
    notifyListeners(); // Isso faz o Badge e o Carrinho atualizarem!
  }

  void removeItem(String productId) {
  _items.remove(productId);
  notifyListeners(); // Notifica a UI para atualizar a lista e o total
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}