part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithCredentialsPressed extends LoginEvent {
  const LoginWithCredentialsPressed({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}

class GetUserCrendentials extends LoginEvent {
  const GetUserCrendentials();
}
