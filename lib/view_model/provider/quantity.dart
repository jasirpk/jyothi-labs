import 'package:flutter/material.dart';

class QuantityCount with ChangeNotifier {
  List<int> _quantities = [];

  // Getter for quantities
  List<int> get quantities => _quantities;

  // Initialize quantities
  void initializeQuantities(int numberOfProducts) {
    // Check if numberOfProducts is valid and reset quantities
    if (numberOfProducts > 0) {
      _quantities = List.generate(numberOfProducts, (_) => 0);
    } else {
      _quantities = []; // Set to empty if no products
    }
    notifyListeners();
  }

  // Increment quantity at a specific index
  void increment(int index) {
    if (index >= 0 && index < _quantities.length) {
      _quantities[index]++;
      notifyListeners();
    }
  }

  // Decrement quantity at a specific index
  void decrement(int index) {
    if (index >= 0 && index < _quantities.length && _quantities[index] > 0) {
      _quantities[index]--;
      notifyListeners();
    }
  }
}
