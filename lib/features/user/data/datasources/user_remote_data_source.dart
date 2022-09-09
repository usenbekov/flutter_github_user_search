import 'dart:convert';

import 'package:flutter_github_user_search/core/error/exceptions.dart';
import 'package:flutter_github_user_search/features/user/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<List<UserModel>>? searchUser(String keyword);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  Uri createUri(String? url) => Uri.parse(url ?? '');
  Uri createUriForSearch(String? keyword) =>
      createUri('https://api.github.com/search/users?q=$keyword');

  @override
  Future<List<UserModel>>? searchUser(String keyword) async {
    final searchResult = await _request(createUriForSearch(keyword));
    final items = List<Map>.from(searchResult['items']);
    final users = await Future.wait(
      items.map(
        (item) => _request(createUri(item['url'])),
      ),
    );
    return users.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<Map> _request(Uri uri) async {
    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ServerException();
    }
  }
}
