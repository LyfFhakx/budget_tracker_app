import 'package:flutter/foundation.dart';
import '../../data.dart';
import '../../domain.dart';

class OperationsProvider with ChangeNotifier {
  String _searchText = '';

  String errorMessage = '';
  List<Operation> _operations = [];

  String get searchText => _searchText;

  OperationsProvider(OperationUseCases operationUseCases)
      : _operationUseCases = operationUseCases;

  final OperationUseCases _operationUseCases;

  Future<void> getOperations() async {
    final result = await _operationUseCases.getOperations();
    result.fold(
        (l) => errorMessage = "Ошибка:${l.errorCode},\n\n${l.description}",
        (r) => _operations = r);
  }

  Future<void> getOperationsByCategory(String category) async {
    final result = await _operationUseCases.getOperationsByCategory(category);
    result.fold(
        (l) => errorMessage = "Ошибка:${l.errorCode},\n\n${l.description}",
        (r) => _operations = r);
  }

  Future<void> addOperation(Operation operation) async {
    final result = await _operationUseCases.addOperation(operation);
    result.fold(
        (l) => errorMessage = "Ошибка:${l.errorCode},\n\n${l.description}",
        (generatedId) {
      final file = Operation(
          operationType: operation.operationType,
          id: generatedId,
          title: operation.title,
          amount: operation.amount,
          date: operation.date,
          category: operation.category);

      _operations.add(file);
      notifyListeners();
    });
  }

  Future<void> updateOperation(Operation operation) async {
    await _operationUseCases.updateOperation(operation).then((_) {

      final oldOperation =
          _operations.firstWhere((element) => element.id == operation.id);
      var newOperation = oldOperation.copyWith(
        operationType: operation.operationType,
        category: operation.category,
        amount: operation.amount,
        title: operation.title,
        date: operation.date,
      );
      var oldOperationIndex =
          _operations.indexWhere((element) => element.id == operation.id);
      _operations.removeAt(oldOperationIndex);
      _operations.insert(oldOperationIndex, newOperation);
      notifyListeners();
    });
  }

  Future<void> deleteOperation(
      int expId, String category, double amount) async {
    await _operationUseCases.deleteOperation(expId, category, amount).then((_) {
      _operations.removeWhere((element) => element.id == expId);
      notifyListeners();
    });
  }

  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  List<Operation> get operations {
    return _searchText != ''
        ? _operations
            .where((e) =>
                e.title.toLowerCase().contains(_searchText.toLowerCase()) ||
                e.category.toLowerCase().contains(_searchText.toLowerCase()))
            .toList()
        : _operations;
  }

  Map<String, dynamic> calculateEntriesAndAmount(String category) {
    double total = 0.0;
    var list = _operations.where((element) => element.category == category);
    for (final i in list) {
      total += i.amount;
    }
    return {'entries': list.length, 'totalAmount': total};
  }

  List<Map<String, dynamic>> calculateWeekOperations() {
    List<Map<String, dynamic>> data = [];

    for (int i = 0; i < 7; i++) {
      double total = 0.0;
      final weekDay = DateTime.now().subtract(Duration(days: i));

      for (int j = 0; j < _operations.length; j++) {
        if (_operations[j].date.year == weekDay.year &&
            _operations[j].date.month == weekDay.month &&
            _operations[j].date.day == weekDay.day) {
          total += _operations[j].amount;
        }
      }
      data.add({'day': weekDay, 'amount': total});
    }
    return data;
  }
}
