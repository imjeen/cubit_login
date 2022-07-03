import 'package:cubit_login/repositories/auth_repository.dart';
import 'package:cubit_login/screens/home/home_screen.dart';
import 'package:cubit_login/screens/login/cubit/login_cubit.dart';
import 'package:cubit_login/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const LoginScreen(),
    );
  }

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: WillPopScope(
          onWillPop: () async => false,
          child: _LoginForm(),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  _LoginForm({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        switch (state.status) {
          case LoginStatus.initial:
            break;
          case LoginStatus.submitting:
            break;
          case LoginStatus.success:
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            break;
          case LoginStatus.error:
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(content: state.failure.message),
            );
            break;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Email'),
                  onChanged: (value) =>
                      context.read<LoginCubit>().emailChanged(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Password'),
                  onChanged: (password) =>
                      context.read<LoginCubit>().passwordChanged(password),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 5.0),
                  onPressed: () => {
                    if (_formKey.currentState?.validate() == true &&
                        state.status != LoginStatus.submitting)
                      {context.read<LoginCubit>().logInWithCredentials()}
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
