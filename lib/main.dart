import 'package:flutter/material.dart';
import 'package:http_api_test/views/screens/user_add.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello world',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.red,
      ),
      home: const UserAdd(),
    );
  }
}
