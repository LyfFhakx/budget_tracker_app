import '../../data.dart';

abstract class CategoryUseCases {
  Future<List<OperationCategory>> getCategories();

  Future<void> updateCategory(
    String category,
    int nEntries,
    double nTotalAmount,
  );
}
