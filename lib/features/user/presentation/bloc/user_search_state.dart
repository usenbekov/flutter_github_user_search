part of 'user_search_bloc.dart';

abstract class UserSearchState extends Equatable {
  const UserSearchState();

  @override
  List<Object> get props => [];
}

class Initial extends UserSearchState {}

class Loading extends UserSearchState {}

class Loaded extends UserSearchState {
  final List<User> users;

  const Loaded({required this.users});

  @override
  List<Object> get props => [...users];
}

class Error extends UserSearchState {
  final String msg;

  const Error({required this.msg});

  @override
  List<Object> get props => [msg];
}
