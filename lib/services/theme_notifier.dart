import 'package:flutter/material.dart';

//responsavel por mudar o theme do app

class ThemeNotifier extends ChangeNotifier {
  Color _primaryColor = Colors.deepPurple;
  Color get primaryColor => _primaryColor;

  void setPrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }
}
