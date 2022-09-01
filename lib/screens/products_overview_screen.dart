import 'package:flutter/material.dart';
import 'package:shop_state/widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ProductsGrid(),
    );
  }
}

