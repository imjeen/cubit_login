import 'package:cubit_login/screens/home/home_screen.dart';
import 'package:cubit_login/screens/login/login_screen.dart';
import 'package:cubit_login/screens/sign_up/sign_up_screen.dart';
import 'package:cubit_login/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );
      case SplashScreen.routeName:
        return SplashScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case SignUpScreen.routeName:
        return SignUpScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute({String? text}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text('Something went wrong! ${text ?? ""}'),
        ),
      ),
    );
  }
}
