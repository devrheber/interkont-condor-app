part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState extends Equatable {
  const LoginState({
    required this.status,
    required this.userDataSession,
    this.message = '',
  });

  factory LoginState.initial() {
    return const LoginState(
      status: LoginStatus.initial,
      userDataSession: {},
    );
  }

  final LoginStatus status;
  final Map<String, dynamic> userDataSession;
  final String message;

  LoginState copyWith({
    LoginStatus? status,
    Map<String, dynamic>? userDataSession,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      userDataSession: userDataSession ?? this.userDataSession,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, userDataSession, message];
}

extension LoginStateX on LoginState {
  bool get isInitial => status == LoginStatus.initial;
  bool get isLoading => status == LoginStatus.loading;
  bool get isSuccess => status == LoginStatus.success;
  bool get isError => status == LoginStatus.error;
}
