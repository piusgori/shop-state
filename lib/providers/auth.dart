import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop_state/models/http_exception.dart';
import 'package:shop_state/private/keys.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get userId {
    return _userId;
  }

  String? get token {
    if (_expiryDate != null && _token != null) {
      if (_expiryDate!.isAfter(DateTime.now())) {
        return _token;
      }
    }
    return null;
  }

  Future<void> _authenticate(
      {required String email,
      required String password,
      required String urlSegment}) async {
    const authority = 'identitytoolkit.googleapis.com';
    final path = '/v1/accounts:$urlSegment';
    final params = {'key': firebaseApiKey};
    final url = Uri.https(authority, path, params);
    final Map<String, Object> body = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    try {
      final response = await http.post(url, body: json.encode(body));
      final data = json.decode(response.body);
      if (data['error'] != null) {
        throw HttpException(data['error']['message']);
      }
      _token = data['idToken'];
      _userId = data['localId'];
      _expiryDate =
          DateTime.now().add(Duration(seconds: int.parse(data['expiresIn'])));
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> signup({required String email, required String password}) async {
    return _authenticate(
        email: email, password: password, urlSegment: 'signUp');
  }

  Future<void> login({required String email, required String password}) async {
    return _authenticate(
        email: email, password: password, urlSegment: 'signInWithPassword');
  }
}
