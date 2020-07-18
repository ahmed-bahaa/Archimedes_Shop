import './product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct ){
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if( prodIndex >=0 ){
      _items[prodIndex] = newProduct;
      notifyListeners();
    }else{
        print('...');
    }
  }

  void deleteProduct( String id){
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
