import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_state/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders(String? authToken) async {
    const authority = 'flutter-shop-c8eda-default-rtdb.firebaseio.com';
    const path = 'orders.json';
    final params = {'auth': authToken};
    final url = Uri.https(authority, path, params);

    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    // ignore: unnecessary_null_comparison
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((key, value) {
      loadedOrders.add(OrderItem(
          id: key,
          amount: value['amount'],
          products: (value['products'] as List<dynamic>)
              .map((e) => CartItem(
                  id: e['id'],
                  title: e['title'],
                  price: e['price'],
                  quantity: e['quantity']))
              .toList(),
          dateTime: DateTime.parse(value['dateTime'])));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total, String? authToken) async {
    const authority = 'flutter-shop-c8eda-default-rtdb.firebaseio.com';
    const path = 'orders.json';
    final params = {'auth': authToken};
    final url = Uri.https(authority, path, params);
    
    final timeStamp = DateTime.now();
    final Map<String, Object> body = {
      'amount': total,
      "dateTime": timeStamp.toIso8601String(),
      'products': cartProducts
          .map((cp) => {
                'id': cp.id,
                'title': cp.title,
                'quantity': cp.quantity,
                'price': cp.price
              })
          .toList(),
    };

    final response = await http.post(url, body: json.encode(body));
    final data = json.decode(response.body);

    _orders.insert(
        0,
        OrderItem(
            id: data['name'],
            amount: total,
            products: cartProducts,
            dateTime: timeStamp));
    notifyListeners();
  }
}
