import 'dart:convert';

import 'package:appalimentacion/data/local/user_preferences.dart';
import 'package:appalimentacion/domain/repository/login_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginRepository loginRepository,
    required UserPreferences userPreferences,
  })  : _loginRepository = loginRepository,
        _userPreferences = userPreferences,
        super(LoginState.initial()) {
    on<GetUserCrendentials>(_onGetUserCrendentials);
    on<LoginWithCredentialsPressed>(_onLogin);
  }

  final LoginRepository _loginRepository;
  final UserPreferences _userPreferences;

  Future<void> _onGetUserCrendentials(GetUserCrendentials event, emit) async {
    final userData = _userPreferences.userData;
    if (userData.isNotEmpty) {
      emit(state.copyWith(userDataSession: jsonDecode(userData)));
    }
  }

  Future<void> _onLogin(LoginWithCredentialsPressed event, emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final user = await _loginRepository.login(event.username, event.password);
      final userDataSession = {
        'username': event.username,
        'user_token': user.token,
      };
      _userPreferences.userData = jsonEncode(userDataSession);
      emit(state.copyWith(
        status: LoginStatus.success,
        userDataSession: userDataSession,
      ));
    } on LoginException catch (e) {
      emit(state.copyWith(status: LoginStatus.error, message: e.message));
      emit(state.copyWith(message: ''));
    }
  }
}
