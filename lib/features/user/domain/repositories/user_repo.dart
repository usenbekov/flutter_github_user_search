import 'package:dartz/dartz.dart';
import 'package:flutter_github_user_search/core/error/failures.dart';
import 'package:flutter_github_user_search/features/user/domain/entities/user.dart';

abstract class UserRepo {
  Future<Either<Failure, List<User>>>? searchUser(String keyword);
}
