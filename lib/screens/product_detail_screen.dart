import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  // ProductDetailScreen({required this.title});

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final product = Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(product.title),
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title),
              background: Hero(tag: product.id, child: Image.network(product.imageUrl, fit: BoxFit.cover,)),
              
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 10),
            Text(
              '\$${product.price}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20
              ),
            ),
            const SizedBox(height: 10),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10), width: double.infinity, child: Text(product.description, textAlign: TextAlign.center, softWrap: true,)),
            const SizedBox(height: 1000,)
              ]
            ),
          ),
        ],
      ),
    );
  }
}
