import 'package:flutter_github_user_search/features/user/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String uname,
    String? avatarUrl,
    required int publicRepos,
  }) : super(uname: uname, avatarUrl: avatarUrl, publicRepos: publicRepos);

  factory UserModel.fromJson(Map json) {
    return UserModel(
      uname: json['login'],
      avatarUrl: json['avatar_url'],
      publicRepos: json['public_repos'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': uname,
      'avatar_url': avatarUrl,
      'public_repos': publicRepos,
    };
  }
}
