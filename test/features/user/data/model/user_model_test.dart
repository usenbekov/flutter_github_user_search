import 'package:flutter_github_user_search/features/user/data/models/user_model.dart';
import 'package:flutter_github_user_search/features/user/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const userModel = UserModel(
    uname: 'testuser',
    avatarUrl: 'testavatar',
    publicRepos: 1,
  );

  const userJsonMap = {
    'login': 'testuser',
    'avatar_url': 'testavatar',
    'public_repos': 1,
  };

  test(
    'should be a subclass of User',
    () async {
      expect(userModel, isA<User>());
    },
  );

  group('fromJson', () {
    test(
      'should return a model with valid data',
      () async {
        final result = UserModel.fromJson(userJsonMap);
        expect(result, userModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a json map with valid data',
      () async {
        final result = userModel.toJson();
        expect(result, userJsonMap);
      },
    );
  });
}
