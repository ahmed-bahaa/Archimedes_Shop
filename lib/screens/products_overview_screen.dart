import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_item.dart';
import '../providers/product.dart';

enum FilterOptions {
  showFavs,
  ALL,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archimedes Shop'),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.showFavs) {
                    _showOnlyFav = true;
                  } else {
                    _showOnlyFav = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text("Only Favourite"),
                      value: FilterOptions.showFavs,
                    ),
                    PopupMenuItem(
                      child: Text("Show All"),
                      value: FilterOptions.ALL,
                    )
                  ]),
        ],
      ),
      body: ProductGrid(_showOnlyFav),
    );
  }
}
