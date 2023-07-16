import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;
  int _selectedOrderOpt = 0;
  int _selectedProductsTotalOpt = 0;

  int get selectedProductsTotalOpt {
    return _selectedProductsTotalOpt;
  }

  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }

  int get selectedOrderOpt {
    return _selectedOrderOpt;
  }

  set selectedProductsTotalOpt(int i) {
    _selectedProductsTotalOpt = i;
    notifyListeners();
  }

  set selectedMenuOpt(int i) {
    _selectedMenuOpt = i;
    notifyListeners();
  }

  set selectedOrderOpt(int i) {
    _selectedOrderOpt = i;
    notifyListeners();
  }
}
