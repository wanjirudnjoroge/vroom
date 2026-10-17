import 'package:flutter/material.dart';
import 'package:vroom/model/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalItemPrice => product.price * quantity;
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalCartPrice {
    return _items.fold(0.0, (total, item) => total + item.totalItemPrice);
  }

  CartItem? findExisting(Product product) {
    for (var item in _items) {
      if (item.product.name == product.name) {
        return item;
      }
    }
    return null;
  }

  void addItem(Product product) {
    final existingItem = findExisting(product);
    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeItem(Product product) {
    final existingItem = findExisting(product);
    if (existingItem != null) {
      if (existingItem.quantity > 1) {
        existingItem.quantity--;
      } else {
        _items.remove(existingItem);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
