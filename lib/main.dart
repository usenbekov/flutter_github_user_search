import 'package:flutter/material.dart';
import 'features/user/presentation/pages/user_search_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub user search',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const UserSearchPage(),
    );
  }
}
