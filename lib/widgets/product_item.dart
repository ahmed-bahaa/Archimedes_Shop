import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final MyProduct = Provider.of<Product>(context );
    final cart = Provider.of<Cart>(context , listen: false );
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: MyProduct.id,
            );
          },
          child: Image.network(
            MyProduct.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, Product , child) => IconButton(
              icon: Icon(
                  MyProduct.isFav ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                MyProduct.toggleMyFav();
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            MyProduct.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(MyProduct.id, MyProduct.price, MyProduct.title);
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
