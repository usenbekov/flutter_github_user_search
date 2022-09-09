import 'package:dartz/dartz.dart';
import 'package:flutter_github_user_search/core/error/exceptions.dart';
import 'package:flutter_github_user_search/core/error/failures.dart';
import 'package:flutter_github_user_search/features/user/data/datasources/user_remote_data_source.dart';
import 'package:flutter_github_user_search/features/user/data/models/user_model.dart';
import 'package:flutter_github_user_search/features/user/data/repositories/user_repo_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

void main() {
  late MockUserRemoteDataSource mockRemoteDataSource;
  late UserRepoImpl repo;

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    repo = UserRepoImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('searchUser', () {
    const keyword = 'test';
    const userModel = UserModel(
      uname: 'testuser',
      avatarUrl: 'testavatar',
      publicRepos: 1,
    );

    test(
      'should return remote data when call to remote data source is successful',
      () async {
        const users = [userModel];
        when(mockRemoteDataSource.searchUser(keyword))
            .thenAnswer((_) async => users);
        final result = await repo.searchUser(keyword);
        verify(mockRemoteDataSource.searchUser(keyword));
        expect(result, equals(const Right(users)));
      },
    );

    test(
      'should return server failure when call to remote data source is unsuccessful',
      () async {
        when(mockRemoteDataSource.searchUser(keyword))
            .thenThrow(ServerException());
        final result = await repo.searchUser(keyword);
        verify(mockRemoteDataSource.searchUser(keyword));
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });
}
