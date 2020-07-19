import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFav;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFav = false,
  });

  void _setFavValue (bool newVal) {
    isFav = newVal;
    notifyListeners();
  }

  Future<void> toggleMyFav() async {
    final oldState = isFav;
    isFav = !isFav;
    notifyListeners();
    final url = "https://flutter-202006.firebaseio.com/products/$id.json";
    try {
        final response =  await http.patch(url,
          body: json.encode({
            'isFav': isFav,
          }));

    if ( response.statusCode >= 400){
        _setFavValue(oldState);
    }
    } catch (err) {
      _setFavValue(oldState);
    }
  }
}
