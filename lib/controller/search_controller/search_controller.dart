import 'package:flutter/material.dart';

abstract class SearchController<T> extends ChangeNotifier {
  final TextEditingController _textEditingController = TextEditingController();
  final List<T> _objects;

  SearchController({@required List<T> objects}) : _objects = objects {
    _textEditingController.addListener(filter);
  }

  TextEditingController get textEditingController => _textEditingController;

  List<T> get allObjects => _objects;

  String get query => _textEditingController.text;

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  void clearQuery() {
    _textEditingController.text = '';
    notifyListeners();
  }

  void filter();
}
