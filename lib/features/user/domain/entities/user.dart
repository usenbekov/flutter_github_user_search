import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uname;
  final String avatarUrl;
  final int publicRepos;

  const User({
    required this.uname,
    required this.avatarUrl,
    required this.publicRepos,
  });

  @override
  List<Object> get props => [uname, avatarUrl, publicRepos];
}
