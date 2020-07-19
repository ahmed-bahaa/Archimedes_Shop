import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show Order;

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orders";

  // .then((_) {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Order>(context, listen: false).fetchAndSetOrders(),
        builder: (context, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapShot.error != null) {
              return Center(child: Text("An error occurred!"));
            } else {
              return Consumer<Order>(
                builder: (ctx, ordersData, child) => ListView.builder(
                  itemCount: ordersData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
