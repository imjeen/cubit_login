import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/sign_up';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SignUpScreen(),
    );
  }

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('SignUp'),
    );
  }
}
