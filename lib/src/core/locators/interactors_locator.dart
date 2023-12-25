

import '../../core.dart';
import '../../data.dart';
import '../../domain.dart';

void initializeInteractors() {
  getIt.registerFactory<OperationUseCases>(
        () => OperationInteractor(dataBaseService: getIt<DataBaseService>()),
  );
  getIt.registerFactory<CategoryUseCases>(
        () => CategoryInteractor(dataBaseService: getIt<DataBaseService>()),
  );
}