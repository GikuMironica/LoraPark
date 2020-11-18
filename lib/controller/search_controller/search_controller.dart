import 'package:flutter/material.dart';

abstract class SearchController extends ChangeNotifier {
  final TextEditingController _textEditingController = TextEditingController();

  SearchController() {
    _textEditingController.addListener(filter);
  }

  TextEditingController get textEditingController => _textEditingController;

  String get query => _textEditingController.text;

  void clearQuery() {
    _textEditingController.text = '';
    notifyListeners();
  }

  void filter();
}
