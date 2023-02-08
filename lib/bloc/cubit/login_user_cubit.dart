import 'package:flutter_bloc/flutter_bloc.dart';

import '../listeners/auth_login_listener.dart';
import '../repo/auth_repository.dart';

enum LoginUserState {
  success,
  wrongPassword,
  userNotFound,
  invalidCredential,
  failed,
  initial
}

class LoginUserCubit extends Cubit<LoginUserState> implements AuthLoginListener {

  final _authRepository = AuthRepository();

  LoginUserCubit(LoginUserState initialState) : super(initialState);

  void loginUser({required String email, required String password}) {
    _authRepository.loginUser(email: email, password: password, authLoginListener: this);
  }

  @override
  void failed() {
    emit(LoginUserState.initial);
    emit(LoginUserState.failed);
  }

  @override
  void success() {
    emit(LoginUserState.success);
  }

  @override
  void userNotFound() {
    emit(LoginUserState.initial);
    emit(LoginUserState.userNotFound);
  }

  @override
  void wrongPassword() {
    emit(LoginUserState.initial);
    emit(LoginUserState.wrongPassword);
  }

  @override
  void invalidCredential() {
    emit(LoginUserState.initial);
    emit(LoginUserState.invalidCredential);
  }
}