import 'package:dartz/dartz.dart';
import 'package:hdrezka_client/core/error/failure.dart';

abstract class RepositoryUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}