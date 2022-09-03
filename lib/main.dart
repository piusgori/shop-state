import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/providers/auth.dart';
import 'package:shop_state/providers/cart.dart';
import 'package:shop_state/providers/orders.dart';
import 'package:shop_state/providers/products.dart';
import 'package:shop_state/screens/auth_screen.dart';
import 'package:shop_state/screens/cart_screen.dart';
import 'package:shop_state/screens/edit_product_screen.dart';
import 'package:shop_state/screens/orders_screen.dart';
import 'package:shop_state/screens/product_detail_screen.dart';
import 'package:shop_state/screens/products_overview_screen.dart';
import 'package:shop_state/screens/splash_screen.dart';
import 'package:shop_state/screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProxyProvider<Auth, Products>(
        //   create: (context) => Products(null, []),
        //   update: (context, value, previous) => Products(value.token, previous!.items),
        // ),
        ChangeNotifierProvider(create: (context) => Products(),),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders(),),
        ChangeNotifierProvider(create: (context) => Auth(),)
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          title: 'Shop',
          debugShowCheckedModeBanner: false,
          home: auth.isAuth ? ProductsOverviewScreen() : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting ? SplashScreen() : AuthScreen(),
          ),
          theme: ThemeData(
            primaryColor: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            UserProductsScreen.routeName: (context) => UserProductsScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen()
          })
      )
    );
  }
}
