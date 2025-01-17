import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {
  final int currentIndex;

  OnboardingInitial(this.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}

class OnboardingComplete extends OnboardingState {}
