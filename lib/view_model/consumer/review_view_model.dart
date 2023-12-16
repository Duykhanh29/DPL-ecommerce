import 'package:flutter/material.dart';

class ReviewViewModel extends ChangeNotifier {
  TextEditingController reviewTextEditingController = TextEditingController();
  double rating = 0;
  void onRatingChanged(double value) {
    rating = value;
    notifyListeners();
  }

  void onTextChanged(String newText) {
    reviewTextEditingController.text = newText;
    notifyListeners();
  }
}
