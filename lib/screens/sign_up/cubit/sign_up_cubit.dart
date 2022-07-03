import 'package:cubit_login/models/failure_model.dart';
import 'package:cubit_login/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;
  SignUpCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(SignUpState.initial());

  void userNameChanged(String userName) {
    emit(state.copyWith(userName: userName, status: SignUpStatus.initial));
  }

  void emailChanged(String email) {
    emit(state.copyWith(email: email, status: SignUpStatus.initial));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password, status: SignUpStatus.initial));
  }

  void signUpWithCredentials() async {
    if (state.status == SignUpStatus.submitting) return;
    try {
      emit(state.copyWith(status: SignUpStatus.submitting));
      await _authRepository.signUpWithEmailAndPassword(
        userName: state.userName,
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: SignUpStatus.success));
    } on Failure catch (err) {
      emit(state.copyWith(failure: err, status: SignUpStatus.error));
    }
  }
}
