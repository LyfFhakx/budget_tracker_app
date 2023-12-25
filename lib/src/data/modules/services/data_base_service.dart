import 'package:sqflite/sqflite.dart';
import '../../../core.dart';
import '../../../data.dart';
import '../../../utils.dart';

class DataBaseService {
  final Database _database;

  DataBaseService({required Database database}) : _database = database;

  Future<List<OperationCategory>> fetchCategories() async {
    try {
      final db = _database;
      return await db.transaction((transaction) async {
        return await transaction.query(cTable).then((data) {
          final converted = List<Map<String, dynamic>>.from(data);
          List<OperationCategory> nList = List.generate(converted.length,
              (index) => OperationCategory.fromString(converted[index]));
          return nList;
        });
      });
    } catch (e, stackTrace) {
      throw AppDatabaseException(message: e, stackTrace: stackTrace);
    }
  }

  Future<void> updateCategory(
    String category,
    int nEntries,
    double nTotalAmount,
  ) async {
    try {
      final db = _database;
      await db.transaction((transaction) async {
        await transaction.update(
          cTable,
          {
            'entries': nEntries,
            'totalAmount': nTotalAmount.toString(),
          },
          where: 'title == ?',
          whereArgs: [category],
        );
      });
    } catch (e, stackTrace) {
      throw AppDatabaseException(message: e, stackTrace: stackTrace);
    }
  }

  Future<void> updateOperation(Operation operation) async {
    try {
      final db = _database;
      await db.transaction((transaction) async {
        await transaction.update(
          oTable,
          operation.toMap(),
          where: 'id == ?',
          whereArgs: [operation.id],
        );
      });
    } catch (e, stackTrace) {

      throw AppDatabaseException(message: e, stackTrace: stackTrace);
    }
  }

  Future<int> addOperation(Operation operation) async {
    try {
      final db = _database;
      var id = -1;
      await db.transaction((transaction) async {
        await transaction
            .insert(oTable, operation.toMap(),
                conflictAlgorithm: ConflictAlgorithm.replace)
            .then(
          (generatedId) {
            id = generatedId;
          },
        );
      });
      return id;
    } catch (e, stackTrace) {
      throw AppDatabaseException(message: e, stackTrace: stackTrace);
    }
  }

  Future<void> deleteOperation(
      int expId, String category, double amount) async {
    try {
      final db = _database;
      await db.transaction((transaction) async {
        await transaction.delete(oTable, where: 'id == ?', whereArgs: [expId]);
      });
    } catch (e, stackTrace) {
      throw AppDatabaseException(message: e, stackTrace: stackTrace);
    }
  }

  Future<List<Operation>> fetchOperations(String category) async {
    try {
      final db = _database;
      return await db.transaction((transaction) async {
        return await transaction.query(oTable,
            where: 'category == ?', whereArgs: [category]).then((data) {
          final converted = List<Map<String, dynamic>>.from(data);
          List<Operation> nList = List.generate(
              converted.length, (index) => Operation.fromMap(converted[index]));
          return nList;
        });
      });
    } catch (e, stackTrace) {
      throw AppDatabaseException(message: e, stackTrace: stackTrace);
    }
  }

  Future<List<Operation>> fetchAllOperations() async {
    try {
      final db = _database;
      return await db.transaction((transaction) async {
        return await transaction.query(oTable).then((data) {
          final converted = List<Map<String, dynamic>>.from(data);
          List<Operation> nList = List.generate(
              converted.length, (index) => Operation.fromMap(converted[index]));
          return nList;
        });
      });
    } catch (e, stackTrace) {
      throw AppDatabaseException(message: e, stackTrace: stackTrace);
    }
  }
}
