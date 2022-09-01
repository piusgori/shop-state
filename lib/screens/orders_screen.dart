import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/providers/orders.dart' show Orders;
import 'package:shop_state/widgets/app_drawer.dart';
import 'package:shop_state/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (context, index) => OrderItem(orders.orders[index]),
      ),
    );
  }
}
