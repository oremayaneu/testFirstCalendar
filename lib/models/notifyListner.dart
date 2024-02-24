import 'package:flutter/material.dart';

class SearchModel extends ChangeNotifier {
  List<dynamic> _searchList = [];

  List<dynamic> get searchList => _searchList;

  void updateSearchList(List<dynamic> newList) {
    _searchList = newList;
    notifyListeners();
  }
}
