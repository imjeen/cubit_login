import 'package:cubit_login/repositories/auth_repository.dart';
import 'package:cubit_login/screens/home/home_screen.dart';
import 'package:cubit_login/screens/login/login_screen.dart';
import 'package:cubit_login/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:cubit_login/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => SignUpCubit(
        authRepository: context.read<AuthRepository>(),
      ),
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async => false,
          child: _SignUpForm(),
        ),
      ),
    );
  }
}

class _SignUpForm extends StatelessWidget {
  _SignUpForm({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        switch (state.status) {
          case SignUpStatus.initial:
            break;
          case SignUpStatus.submitting:
            break;
          case SignUpStatus.success:
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            break;
          case SignUpStatus.error:
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
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'userName'),
                  onChanged: (value) =>
                      context.read<SignUpCubit>().userNameChanged(value),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Email'),
                  onChanged: (value) =>
                      context.read<SignUpCubit>().emailChanged(value),
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
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'password'),
                  onChanged: (value) =>
                      context.read<SignUpCubit>().userNameChanged(value),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 5.0),
                  onPressed: () => {
                    if (_formKey.currentState?.validate() == true &&
                        state.status != SignUpStatus.submitting)
                      {context.read<SignUpCubit>().signUpWithCredentials()}
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.black,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    onSurface: Colors.transparent,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: const Text('have a Account? Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
