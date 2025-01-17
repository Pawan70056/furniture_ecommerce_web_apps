import 'package:bloc/bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<NavigateToOnboardingEvent>((event, emit) async {
      emit(SplashLoading());
      await Future.delayed(const Duration(seconds: 3)); // Simulate splash delay
      emit(SplashNavigateToOnboarding());
    });
  }
}
