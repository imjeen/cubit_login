import 'package:cubit_login/custom_router.dart';
import 'package:cubit_login/repositories/auth_repository.dart';
import 'package:cubit_login/theme.dart';
import 'package:cubit_login/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
      ],
      child: MaterialApp(
        theme: theme,
        home: Container(),
        onGenerateRoute: CustomRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
