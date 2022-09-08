import 'package:dartz/dartz.dart';
import 'package:flutter_github_user_search/features/user/domain/entities/user.dart';
import 'package:flutter_github_user_search/features/user/domain/repositories/user_repo.dart';
import 'package:flutter_github_user_search/features/user/domain/usecases/search_user.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockUserRepo extends Mock implements UserRepo {}

void main() {
  late SearchUser usecase;
  late MockUserRepo mockUserRepo;
  const keyword = 'test';

  const user = User(
    uname: 'testuser',
    avatarUrl: 'testavatar',
    publicRepos: 1,
  );

  setUp(() {
    mockUserRepo = MockUserRepo();
    usecase = SearchUser(mockUserRepo);
  });

  test(
    'should get data from repo',
    () async {
      when(mockUserRepo.searchUser(keyword))
          .thenAnswer((_) async => const Right([user]));

      final res = await usecase(const Params(value: keyword));

      expect(res, const Right([user]));
      verify(mockUserRepo.searchUser(keyword));
      verifyNoMoreInteractions(mockUserRepo);
    },
  );
}
