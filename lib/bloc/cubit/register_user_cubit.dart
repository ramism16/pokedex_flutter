import 'package:flutter_bloc/flutter_bloc.dart';

import '../listeners/auth_registration_listener.dart';
import '../repo/auth_repository.dart';

enum RegisterUserState {
  success,
  userExists,
  weakPassword,
  failed,
  initial
}

class RegisterUserCubit extends Cubit<RegisterUserState> implements AuthRegistrationListener {

  final _authRepository = AuthRepository();

  RegisterUserCubit(RegisterUserState initialState) : super(initialState);

  void registerUser({required String email, required String password, required String name}) {
    _authRepository.registerUser(email: email, password: password, name: name, authRegistrationListener: this);
  }

  @override
  void failed() {
    emit(RegisterUserState.initial);
    emit(RegisterUserState.failed);
  }

  @override
  void success() {
    emit(RegisterUserState.success);
  }

  @override
  void userExists() {
    emit(RegisterUserState.initial);
    emit(RegisterUserState.userExists);
  }

  @override
  void weakPassword() {
    emit(RegisterUserState.initial);
    emit(RegisterUserState.weakPassword);
  }
}