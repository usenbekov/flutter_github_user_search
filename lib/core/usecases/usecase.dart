import 'package:dartz/dartz.dart';
import 'package:flutter_github_user_search/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>?> call(Params params);
}
