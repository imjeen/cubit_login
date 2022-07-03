part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, submitting, success, error }

class SignUpState extends Equatable {
  final String userName;
  final String email;
  final String password;
  final SignUpStatus status;
  final Failure failure;

  const SignUpState({
    required this.userName,
    required this.email,
    required this.password,
    required this.status,
    required this.failure,
  });

  factory SignUpState.initial() {
    return const SignUpState(
      userName: '',
      email: '',
      password: '',
      status: SignUpStatus.initial,
      failure: Failure(),
    );
  }

  SignUpState copyWith({
    String? userName,
    String? email,
    String? password,
    SignUpStatus? status,
    Failure? failure,
  }) {
    return SignUpState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object> get props => [];
}
