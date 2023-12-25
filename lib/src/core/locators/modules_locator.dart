import 'package:sqflite/sqflite.dart';
import '../../core.dart';
import '../../data.dart';

Future<void> initializeModules() async {
  getIt.registerSingleton<Database>(await DatabaseHelper.instance.database);

  getIt.registerSingleton<DataBaseService>(
    DataBaseService(database: getIt()),
  );
}
