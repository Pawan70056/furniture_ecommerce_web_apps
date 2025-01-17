import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial(0)) {
    on<OnboardingPageChanged>((event, emit) {
      emit(OnboardingInitial(event.currentIndex));
    });

    on<OnboardingFinished>((event, emit) {
      emit(OnboardingComplete());
    });
  }
}
