import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funiture_ecommerce/app/constants/strings.dart';
import 'package:funiture_ecommerce/app/widget/onboarding_indicator.dart';
import 'package:funiture_ecommerce/app/widget/onboarding_page.dart';
import 'package:funiture_ecommerce/features/onboarding/presentation/view_model/onboarding_bloc.dart';
import 'package:funiture_ecommerce/features/onboarding/presentation/view_model/onboarding_event.dart';
import 'package:funiture_ecommerce/features/onboarding/presentation/view_model/onboarding_state.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  // Define the PageController
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingComplete) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        builder: (context, state) {
          final bloc = context.read<OnboardingBloc>();
          final onboardingData = OnboardingConstants.onboardingData;

          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController, // Attach the controller here
                    onPageChanged: (index) {
                      bloc.add(OnboardingPageChanged(index));
                    },
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) {
                      final data = onboardingData[index];
                      return OnboardingPage(
                        image: data['image']!,
                        title: data['title']!,
                        description: data['description']!,
                      );
                    },
                  ),
                ),
                if (state is OnboardingInitial)
                  OnboardingIndicator(
                    currentIndex: state.currentIndex,
                    total: onboardingData.length,
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          bloc.add(OnboardingFinished());
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).hintColor,
                        ),
                        onPressed: () {
                          if (state is OnboardingInitial &&
                              state.currentIndex ==
                                  onboardingData.length - 1) {
                            bloc.add(OnboardingFinished());
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        child: Text(
                          state is OnboardingInitial &&
                              state.currentIndex ==
                                  onboardingData.length - 1
                              ? "Get Started"
                              : "Next",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
