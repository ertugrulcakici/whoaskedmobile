import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whoaskedmobile/core/services/api_service.dart';
import 'package:whoaskedmobile/core/services/navigation_service.dart';
import 'package:whoaskedmobile/view/home/home_view.dart';
import 'package:whoaskedmobile/view/login/login_view.dart';
import 'package:whoaskedmobile/view/splash/splash_view.dart';

import 'view/profile/profile_view.dart';

Future<void> main(List<String> args) async {
  await ApiService.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenUtilInit(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: "/",
          navigatorKey: NavigationService.instance.navigatorKey,
          routes: {
            "/": (context) => const SplashView(),
            "/login": (context) => const LoginView(),
            "/home": (context) => const HomeView(),
            "/profile": (context) => const ProfileView(),
          },
        ),
      ),
    );
  }
}
