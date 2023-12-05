import 'package:flutter/material.dart';

final class NavigationService {
  // singleton boilerplate
  static final NavigationService _instance =
      NavigationService._privateConstructor();
  static NavigationService get instance => _instance;
  NavigationService._privateConstructor();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  BuildContext? get currentContext => _navigatorKey.currentContext;
}
