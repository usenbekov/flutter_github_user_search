import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_github_user_search/core/error/failures.dart';
import 'package:flutter_github_user_search/core/util/debounce.dart';
import 'package:flutter_github_user_search/features/user/domain/entities/user.dart';
import 'package:flutter_github_user_search/features/user/domain/usecases/search_user.dart';

part 'user_search_event.dart';
part 'user_search_state.dart';

const searchDebaunceId = 'UserSearchBlocDebaunceId';
const serverFailureMsg = 'Server failure!';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  final SearchUser searchUser;

  UserSearchBloc({
    required this.searchUser,
  }) : super(Initial()) {
    on<UserSearchEvent>((event, emit) async {
      if (event is SearchUserWithKeyword) {
        Debounce.cancel(searchDebaunceId);
        if (event.keyword.isEmpty) {
          emit((Initial()));
        } else {
          emit(Loading());
          if (await Debounce.canContinue(searchDebaunceId, ms: 700)) {
            final result = await searchUser(Params(value: event.keyword));
            result!.fold((failure) {
              emit(Error(msg: _failureToMessage(failure)));
            }, (users) {
              emit(Loaded(users: users));
            });
          }
        }
      }
    });
  }
}

String _failureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMsg;
    default:
      return 'Unexpected error!';
  }
}
