import 'package:flutter/material.dart';
import 'package:frontend/providers/automaticDate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AutomaticDateList with ChangeNotifier {
  List<AutomaticDate> items = [];

  AutomaticDateList();

  void addToList(AutomaticDate automaticDate) {
    items.add(automaticDate);
    notifyListeners();
  }

  List<AutomaticDate> get getItems => items;
}
