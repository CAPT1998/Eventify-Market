import 'package:flutter/material.dart';
import 'package:quickie_event/Quicke_Features/Model/ProductDetailResponseModel.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _cartItems = [];
  int? amount = 0;

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product, int quantity) {
    // Check if the product already exists in the cart
    bool alreadyInCart = _cartItems.any((item) => item.id == product.id);
    if (!alreadyInCart) {
      _cartItems.add(product);
      notifyListeners();
    }
    amount = quantity;
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
