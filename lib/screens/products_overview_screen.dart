import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/providers/auth.dart';
import 'package:shop_state/providers/cart.dart';
import 'package:shop_state/providers/products.dart';
import 'package:shop_state/screens/cart_screen.dart';
import 'package:shop_state/widgets/app_drawer.dart';
import 'package:shop_state/widgets/badge.dart';
import 'package:shop_state/widgets/products_grid.dart';

enum FliterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); //WON"T WORK!;
    // Future.delayed(Duration.zero).then((value) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }


  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context)
          .fetchAndSetProducts(Provider.of<Auth>(context).token)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FliterOptions val) {
              setState(() {
                if (val == FliterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FliterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FliterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: Icon(Icons.shopping_cart)),
            builder: (_, cartData, ch) => Badge(
              value: cartData.itemCount.toString(),
              color: Colors.red,
              child: Container(child: ch),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
