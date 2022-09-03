import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/providers/auth.dart';
import 'package:shop_state/providers/orders.dart' show Orders;
import 'package:shop_state/widgets/app_drawer.dart';
import 'package:shop_state/widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var _ordersFuture;
  Future _obtainOrdersFutur() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders(Provider.of<Auth>(context, listen: false).token);
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFutur();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return const Center(
                child: Text('An error occured'),
              );
            } else {
              return Consumer<Orders>(
                  builder: (context, orders, child) => ListView.builder(
                        itemCount: orders.orders.length,
                        itemBuilder: (context, index) =>
                            OrderItem(orders.orders[index]),
                      ));
            }
          }
        },
      ),
    );
  }
}
