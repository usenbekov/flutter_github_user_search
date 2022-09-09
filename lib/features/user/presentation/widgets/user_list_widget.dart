import 'package:flutter/material.dart';
import 'package:flutter_github_user_search/features/user/domain/entities/user.dart';

class UserListWidget extends StatelessWidget {
  final List<User> users;
  const UserListWidget({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          title: Text(user.uname),
          subtitle: Text('${user.publicRepos} repositories'),
          leading: UserAvatar(url: user.avatarUrl),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    );
  }
}

class UserAvatar extends StatelessWidget {
  final String? url;
  const UserAvatar({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url == null) return Container();
    return CircleAvatar(
      child: Image.network(url!),
    );
  }
}
