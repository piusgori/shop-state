import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newFav) {
    isFavorite = newFav;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String? authToken, String? userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    const authority = 'flutter-shop-c8eda-default-rtdb.firebaseio.com';
    final path = 'userFavorites/$userId/$id.json';
    final params = {'auth': authToken};
    final url = Uri.https(authority, path, params);

    final body = isFavorite;
    try {
      final response = await http.put(url, body: json.encode(body));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (err) {
      _setFavValue(oldStatus);
    }
  }
}
