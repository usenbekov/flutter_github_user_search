import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_github_user_search/core/error/failures.dart';
import 'package:flutter_github_user_search/core/usecases/usecase.dart';
import 'package:flutter_github_user_search/features/user/domain/entities/user.dart';
import 'package:flutter_github_user_search/features/user/domain/repositories/user_repo.dart';

class SearchUser implements UseCase<User, Params> {
  final UserRepo repo;

  SearchUser(this.repo);

  @override
  Future<Either<Failure, User>?> call(Params params) async {
    return await repo.searchUser(params.value);
  }
}

class Params extends Equatable {
  final String value;

  const Params({required this.value});

  @override
  List<Object> get props => [value];
}
