// register_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funiture_ecommerce/features/auth/domain/entity/user.dart';
import 'package:funiture_ecommerce/features/auth/domain/repository/auth_repository.dart';
import 'package:funiture_ecommerce/features/auth/domain/use_cases/register_use_case.dart';
import 'package:funiture_ecommerce/features/auth/presentation/view_model/register/register_event.dart';
import 'package:funiture_ecommerce/features/auth/presentation/view_model/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase, required AuthRepository authRepository}) : super(RegisterInitial()) {
    on<SubmitRegistration>(_onSubmitRegistration);
  }

  Future<void> _onSubmitRegistration(SubmitRegistration event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());

    try {
      // Execute the register use case
      final result = await registerUseCase.execute(event.email as User, event.password);
      emit(RegisterSuccess('Registration Successful'));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
