import './product.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://i.pinimg.com/originals/76/49/76/7649761f40db67f5c8e879f38f8e45b1.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Helicopter',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://i.pinimg.com/originals/91/e1/ac/91e1acbf84831475695804a12d7ecee3.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://s3files.core77.com/blog/images/lead_n_spotlight/476199_spotlight_52037_biO7SV8kA.png',
    ),
    Product(
      id: 'p4',
      title: 'Gears',
      description: 'Leonardo Da Vinci Machine Gears Engineer Drawing !',
      price: 29.99,
      imageUrl: 'https://i.ebayimg.com/images/g/F6cAAOSwMtxXrOdZ/s-l400.jpg',
    ),
  ];

  List<Product> get showFavOnly {
    return _items.where((prodItem) => prodItem.isFav).toList();
  }

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addProduct(Product product) async {
    const url = "https://flutter-202006.firebaseio.com/products.json";
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFav': product.isFav,
          }));

      print(json.decode(response.body));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> fetchAndSetProducts() async {
    const url = "https://flutter-202006.firebaseio.com/products.json";
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
    }catch(err){
      throw(err);
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
