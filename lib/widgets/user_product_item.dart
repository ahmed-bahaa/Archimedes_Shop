import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../screens/edit_product_screen.dart';
import 'package:provider/provider.dart';  
import '../providers/product_provider.dart';

class UserProductItem extends StatelessWidget {
  @required
  String title;
  @required
  String imageUrl;
  @required String id;
  
  UserProductItem(this.title, this.imageUrl , this.id);

  @override
  Widget build(BuildContext context) {
    final scafold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName , arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async{
                try{
                  await Provider.of<Products>(context , listen: false).deleteProduct(id);
                }catch(err){
                  scafold.showSnackBar(SnackBar(content: Text('Deleting Failed!' , textAlign: TextAlign.center,)),);
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
