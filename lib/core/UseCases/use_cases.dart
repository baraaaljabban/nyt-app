import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

abstract class UseCaseNoParamsNoFuture<Type> {
  Either<Failure, Type> call();
}

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}
