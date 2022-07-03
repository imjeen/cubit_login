import 'dart:async';

import 'package:cubit_login/models/user_model.dart';
import 'package:cubit_login/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthState.unknown()) {
    // on<AuthEvent>((event, emit) {});
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthUserChanged>(_onUserChanged);
    _userSubscription =
        _authRepository.user.listen((user) => add(AuthUserChanged(user: user)));
  }

  void _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.logOut();
    emit(AuthState.unauthenticated());
  }

  void _onUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    final user = event.user;
    emit(user.isNotEmpty
        ? AuthState.authenticated(user: user)
        : AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}