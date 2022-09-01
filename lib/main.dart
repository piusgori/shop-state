import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/providers/cart.dart';
import 'package:shop_state/providers/orders.dart';
import 'package:shop_state/providers/products.dart';
import 'package:shop_state/screens/cart_screen.dart';
import 'package:shop_state/screens/orders_screen.dart';
import 'package:shop_state/screens/product_detail_screen.dart';
import 'package:shop_state/screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders(),)
      ],
      child: MaterialApp(
          title: 'Shop',
          debugShowCheckedModeBanner: false,
          home: ProductsOverviewScreen(),
          theme: ThemeData(
            primaryColor: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen()
          }),
    );
  }
}
