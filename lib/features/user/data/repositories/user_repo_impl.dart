import 'package:dartz/dartz.dart';
import 'package:flutter_github_user_search/core/error/exceptions.dart';
import 'package:flutter_github_user_search/core/error/failures.dart';
import 'package:flutter_github_user_search/features/user/data/datasources/user_remote_data_source.dart';
import 'package:flutter_github_user_search/features/user/domain/entities/user.dart';
import 'package:flutter_github_user_search/features/user/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDataSource remoteDataSource;

  UserRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<User>>> searchUser(String keyword) async {
    try {
      final data = await remoteDataSource.searchUser(keyword);
      return Right(data!);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
