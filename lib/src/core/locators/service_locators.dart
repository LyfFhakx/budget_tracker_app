import 'package:get_it/get_it.dart';

import 'interactors_locator.dart';
import 'modules_locator.dart';

final getIt = GetIt.instance;

Future<void> serviceLocatorInitialization() async {
  await getIt.reset();
  await initializeModules();
  initializeInteractors();
  await getIt.allReady();
}
