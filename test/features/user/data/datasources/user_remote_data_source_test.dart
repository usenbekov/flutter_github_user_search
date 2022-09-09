import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_github_user_search/core/error/exceptions.dart';
import 'package:flutter_github_user_search/features/user/data/datasources/user_remote_data_source.dart';
import 'package:flutter_github_user_search/features/user/data/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'user_remote_data_source_test.mocks.dart';

@GenerateMocks([],
    customMocks: [MockSpec<http.Client>(returnNullOnMissingStub: true)])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  late MockClient mockHttpClient;
  late UserRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = UserRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpGet(Uri? uri, int status, String respBody) {
    when(mockHttpClient.get(uri ?? any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(respBody, status));
  }

  group('searchUser', () {
    const keyword = 'test';
    const userJsonMap = {
      'login': 'testuser',
      'avatar_url': 'testavatar',
      'public_repos': 1,
    };
    final userModel = UserModel.fromJson(userJsonMap);

    test(
      'should return List<User> when success',
      () async {
        const userRes = {'url': 'testurl'};
        const usersRes = [userRes, userRes];

        final searchUri = dataSource.createUriForSearch(keyword);
        final userUri = dataSource.createUri(userRes['url']);
        setUpMockHttpGet(searchUri, 200, json.encode({'items': usersRes}));
        setUpMockHttpGet(userUri, 200, json.encode(userJsonMap));

        final result = await dataSource.searchUser(keyword);

        expect(result, equals([userModel, userModel]));
      },
    );

    test(
      'should throw ServerException failed',
      () async {
        setUpMockHttpGet(null, 404, 'test error message');

        expect(() => dataSource.searchUser(keyword),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
