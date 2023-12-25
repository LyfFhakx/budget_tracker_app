import '../../data.dart';
import '../../domain.dart';

class CategoryInteractor extends CategoryUseCases {
  final DataBaseService dataBaseService;

  CategoryInteractor({required this.dataBaseService});

  @override
  Future<List<OperationCategory>> getCategories() async {
    final result = await dataBaseService.fetchCategories();
    return result;
  }

  @override
  Future<void> updateCategory(
      String category, int nEntries, double nTotalAmount) async {
    await dataBaseService.updateCategory(category, nEntries, nTotalAmount);
  }
}
