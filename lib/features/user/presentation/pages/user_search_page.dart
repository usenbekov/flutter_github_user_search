import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_user_search/features/user/presentation/bloc/user_search_bloc.dart';
import 'package:flutter_github_user_search/features/user/presentation/widgets/loading_widget.dart';
import 'package:flutter_github_user_search/features/user/presentation/widgets/msg_widget.dart';
import 'package:flutter_github_user_search/features/user/presentation/widgets/search_field_widget.dart';
import 'package:flutter_github_user_search/features/user/presentation/widgets/user_list_widget.dart';
import 'package:flutter_github_user_search/service_locator.dart';

class UserSearchPage extends StatelessWidget {
  const UserSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repo+'),
      ),
      body: BlocProvider(
        create: (_) => sl<UserSearchBloc>(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _UserSearchPage(),
        ),
      ),
    );
  }
}

class _UserSearchPage extends StatelessWidget {
  const _UserSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        SearchFieldWidget(onInputChanged: (value) {
          context.read<UserSearchBloc>().add(SearchUserWithKeyword(value));
        }),
        Expanded(
          child: BlocBuilder<UserSearchBloc, UserSearchState>(
            builder: (context, state) {
              if (state is Initial) {
                return const MsgWidget(msg: 'Type to search');
              } else if (state is Loading) {
                return Column(children: const [LoadingWidget()]);
              } else if (state is Loaded) {
                if (state.users.isEmpty) {
                  return const MsgWidget(msg: 'No results');
                }
                return UserListWidget(users: state.users);
              } else if (state is Error) {
                return MsgWidget(msg: state.msg, color: Colors.redAccent);
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
