
import 'package:flutter/foundation.dart';
import '../../data.dart';
import '../../domain.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryUseCases _categoryUseCases;

  List<OperationCategory> _categories = [];

  CategoryProvider(CategoryUseCases categoryUseCases)
      : _categoryUseCases = categoryUseCases;

  List<OperationCategory> get categories => _categories;

  Future<void> getCategories() async {
    final result = await _categoryUseCases.getCategories();
    _categories = result;
  }

  Future<void> updateCategory(
      String category, int nEntries, double nTotalAmount) async {
    await _categoryUseCases
        .updateCategory(category, nEntries, nTotalAmount)
        .then((_) {
      var oldCategory = _categories.firstWhere((element) => element.title == category);
     var updatedCategory= oldCategory.copyWith(entries: nEntries, totalAmount: nTotalAmount);
      var oldIndex =
          _categories.indexWhere((element) => element.title == category);
      _categories.removeAt(oldIndex);
      _categories.insert(oldIndex, updatedCategory);
      notifyListeners();
    });
  }

  OperationCategory findCategory(String title) {
    return _categories.firstWhere((element) => element.title == title);
  }

  double calculateTotalOperations() {
    var totalAmount = 0.0;
    for (var category in _categories) {
      if (category.title != "Доходы") {
        totalAmount += category.totalAmount;
      }
    }
    return totalAmount;
  }

  double getIncome() {
    return _categories
        .where((element) => element.title == "Доходы")
        .first
        .totalAmount;
  }
}
