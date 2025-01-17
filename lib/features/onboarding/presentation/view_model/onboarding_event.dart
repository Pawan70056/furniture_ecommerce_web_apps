import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnboardingPageChanged extends OnboardingEvent {
  final int currentIndex;

  OnboardingPageChanged(this.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}

class OnboardingFinished extends OnboardingEvent {}
