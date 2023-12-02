import 'package:flutter/material.dart';
import 'package:whoaskedmobile/view/home/home_view.dart';
import 'package:whoaskedmobile/view/login/login_view.dart';
import 'package:whoaskedmobile/view/splash/splash_view.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashView(),
        "/login": (context) => const LoginView(),
        "/home": (context) => const HomeView()
      },
    );
  }
}
