import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User with ChangeNotifier {
  String _token;
  String _userId;
  String _firstName;
  String _lastName;
  String _function;
  bool _active;
  DateTime _expiryDate;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get firstName {
    return _firstName;
  }

  String get lastName {
    return _lastName;
  }

  String get function {
    return _function;
  }

  bool get active {
    return _active;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<void> fetchProfileDetails() async {
    const url = "http://10.0.2.2:8080/api/user/me";

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final responseData = json.decode(response.body);
    _userId = responseData["employeeId"];
    _firstName = responseData["firstName"];
    _lastName = responseData["lastName"];
    _function = responseData["function"];
    _active = responseData["active"];
    _userId = responseData['employeeId'];
    _expiryDate = DateTime.now().add(
      Duration(milliseconds: 3600000),
    );

    _autoLogout();
    notifyListeners();
  }

  Future<void> logIn(String email, String password) async {
    const url = "http://10.0.2.2:8080/auth/login";

    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
    final responseData = json.decode(response.body);
    _token = responseData['accessToken'];
    fetchProfileDetails();
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpire = _expiryDate.difference(DateTime.now()).inMilliseconds;
    _authTimer = Timer(Duration(milliseconds: timeToExpire), logout);
  }
}
