import 'package:bloc/bloc.dart';
import 'package:funiture_ecommerce/features/auth/domain/entity/credentials.dart';
import 'package:funiture_ecommerce/features/auth/domain/repository/auth_repository.dart';
import 'package:funiture_ecommerce/features/auth/domain/use_cases/login_use_case.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase, required AuthRepository authRepository}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      // Pass the username and password as separate arguments
      final isAuthenticated = await loginUseCase.execute(event.username as Credentials, event.password);

      if (isAuthenticated) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Invalid username or password."));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}