import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  Color _primaryColor = Colors.deepPurple;
  Color get primaryColor => _primaryColor;

  void setPrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }
}
