part of 'user_search_bloc.dart';

abstract class UserSearchEvent extends Equatable {
  const UserSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchUserWithKeyword extends UserSearchEvent {
  final String keyword;

  const SearchUserWithKeyword(this.keyword);

  @override
  List<Object> get props => [keyword];
}
