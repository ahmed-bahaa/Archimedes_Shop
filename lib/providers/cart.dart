import 'package:flutter/foundation.dart';

class CartItem {
  @required
  final String id;
  @required
  final String title;
  @required
  final int quantity;
  @required
  final double price;

  CartItem({this.id, this.title, this.price, this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cardItem) {
      total += cardItem.price * cardItem.quantity;
    });
    return total;
  }

  void removeItem(productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (ExistingCartItem) => CartItem(
              id: ExistingCartItem.id,
              title: ExistingCartItem.title,
              price: ExistingCartItem.price,
              quantity: (ExistingCartItem.quantity - 1) , ));
    } else {
      _items.remove(productId);
    }
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existedProduct) => CartItem(
                id: existedProduct.id,
                title: existedProduct.title,
                price: existedProduct.price,
                quantity: existedProduct.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
