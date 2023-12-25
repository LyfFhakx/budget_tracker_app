import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/core.dart';
import 'src/data.dart';
import 'src/view/screens/all_operations.dart';
import 'src/view/screens/category_screen.dart';
import 'src/view/screens/operation_screen.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await serviceLocatorInitialization();
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => OperationsProvider(getIt())),
          ChangeNotifierProvider(create: (_) => CategoryProvider(getIt()))
        ],
        child: const MyApp(),
      ),
    );
  }, (e, stackTrace) {
    if (kDebugMode) {
      print("Exception:$e\n\nstackTrace:$stackTrace");
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: CategoryScreen.name,
      routes: {
        CategoryScreen.name: (_) => const CategoryScreen(),
        OperationScreen.name: (_) => const OperationScreen(),
        AllOperations.name: (_) => const AllOperations(),
      },
    );
  }
}
