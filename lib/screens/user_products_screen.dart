import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/providers/products.dart';
import 'package:shop_state/screens/edit_product_screen.dart';
import 'package:shop_state/widgets/app_drawer.dart';
import 'package:shop_state/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Your products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProductItem(
                  id: productsData.items[i].id,
                  imageUrl: productsData.items[i].imageUrl,
                  title: productsData.items[i].title),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
