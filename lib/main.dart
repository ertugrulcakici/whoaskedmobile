import 'package:flutter/material.dart';
import 'package:whoaskedmobile/view/login/login_view.dart';

void main(List<String> args) {}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginView(),
    );
  }
}
