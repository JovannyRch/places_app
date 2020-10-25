import 'package:flutter/material.dart';

class SliderModel with ChangeNotifier {
  double _currentPage = 0;

  double get currentPage {
    return _currentPage;
  }

  set currentPage(double currentpage) {
    _currentPage = currentpage;
    notifyListeners();
  }
}
