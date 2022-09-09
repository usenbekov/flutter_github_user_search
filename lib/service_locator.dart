import 'package:flutter_github_user_search/features/user/data/datasources/user_remote_data_source.dart';
import 'package:flutter_github_user_search/features/user/data/repositories/user_repo_impl.dart';
import 'package:flutter_github_user_search/features/user/domain/repositories/user_repo.dart';
import 'package:flutter_github_user_search/features/user/domain/usecases/search_user.dart';
import 'package:flutter_github_user_search/features/user/presentation/bloc/user_search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => UserSearchBloc(searchUser: sl()),
  );

  // use cases
  sl.registerLazySingleton(() => SearchUser(sl()));

  // repositories
  sl.registerLazySingleton<UserRepo>(
    () => UserRepoImpl(remoteDataSource: sl()),
  );

  // data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  // others
  sl.registerLazySingleton(() => http.Client());
}
