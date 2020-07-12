import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_item.dart';
import '../providers/product.dart';

class ProductsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archimedes Shop'),
      ),
      body: ProductGrid() ,
    );
  }
}
