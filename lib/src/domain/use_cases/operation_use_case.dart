
import '../../data.dart';
import '../../utils/either.dart';
import '../failure/failure.dart';

typedef OperationResponse = Either<Failure, List<Operation>>;
typedef AddOperationResponse = Either<Failure, int>;
typedef UpdateOperationResponse = Either<Failure, int>;

abstract class OperationUseCases {
  Future<OperationResponse> getOperations();

  Future<OperationResponse> getOperationsByCategory(String category);

  Future<AddOperationResponse> addOperation(Operation operation);

  Future<void> updateOperation(Operation operation);

  Future<void> deleteOperation(int expId, String category, double amount);
}
