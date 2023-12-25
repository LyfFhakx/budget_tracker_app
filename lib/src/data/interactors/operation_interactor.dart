import 'package:flutter/foundation.dart';

import '../../data.dart';
import '../../domain.dart';
import '../../utils/either.dart';

class OperationInteractor extends OperationUseCases {
  final DataBaseService dataBaseService;

  OperationInteractor({required this.dataBaseService});

  @override
  Future<AddOperationResponse> addOperation(Operation operation) async {
    try {
      final response = await dataBaseService.addOperation(operation);
      return Right(response);
    } on LocalFailure catch (e) {
      return Left(LocalFailure(e.toString()));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Exception:$e,\n\n stackTrace:$stackTrace}");
      }
      return Left(UnknownFailure(stackTrace));
    }
  }

  @override
  Future<void> updateOperation(Operation operation) async {
    try {
      await dataBaseService.updateOperation(operation);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Exception:$e,\n\n stackTrace:$stackTrace}");
      }
    }
  }

  @override
  Future<void> deleteOperation(
      int expId, String category, double amount) async {
    await dataBaseService.deleteOperation(expId, category, amount);
  }

  @override
  Future<OperationResponse> getOperations() async {
    try {
      final response = await dataBaseService.fetchAllOperations();
      return Right(response);
    } on LocalFailure catch (e) {
      return Left(LocalFailure(e.toString()));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Exception:$e,\n\n stackTrace:$stackTrace}");
      }
      return Left(UnknownFailure(stackTrace));
    }
  }

  @override
  Future<OperationResponse> getOperationsByCategory(String category) async {
    try {
      final response = await dataBaseService.fetchOperations(category);
      return Right(response);
    } on LocalFailure catch (e) {
      return Left(LocalFailure(e.toString()));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Exception:$e,\n\n stackTrace:$stackTrace}");
      }
      return Left(UnknownFailure(stackTrace));
    }
  }
}
