import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../utils.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initiateDatabase();
    return _database!;
  }

  initiateDatabase() async {
    final dbDirectory = await getDatabasesPath();
    const dbName = 'budget_tracker.db';
    final path = join(dbDirectory, dbName);

    return await openDatabase(
      path,
      version: 1,
      singleInstance: true,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.transaction((transaction) async {
      await transaction.execute('''CREATE TABLE $cTable(
        title TEXT,
        entries INTEGER,
        totalAmount TEXT
      )''');

      await transaction.execute('''CREATE TABLE $oTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        operationType TEXT,
        title TEXT,
        amount TEXT,
        date TEXT,
        category TEXT
      )''');
      await transaction.insert(cTable, {
        'title': "Доходы",
        'entries': 0,
        'totalAmount': (0.0).toString(),
      });
      for (int i = 0; i < icons.length; i++) {
        await transaction.insert(cTable, {
          'title': icons.keys.toList()[i],
          'entries': 0,
          'totalAmount': (0.0).toString(),
        });
      }
    });
  }
}
