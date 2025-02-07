import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furniture_shopping/features/auth/presentation/view/login_view.dart';
import 'package:furniture_shopping/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:furniture_shopping/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockLoginBloc extends Mock implements LoginBloc {}

void main() {
  late SplashCubit splashCubit;
  late MockLoginBloc mockLoginBloc;

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    splashCubit = SplashCubit(mockLoginBloc);
  });

  testWidgets('SplashCubit navigates to LoginView after 2 seconds',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            splashCubit.init(context);
            return const Scaffold(body: Text('Splash Screen'));
          },
        ),
      ),
    );

    // Initially, we should be on the splash screen
    expect(find.text('Splash Screen'), findsOneWidget);
    expect(find.byType(LoginView), findsNothing);

    // Simulate 2 seconds passing
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // After 2 seconds, we should be on the LoginView
    expect(find.byType(LoginView), findsOneWidget);
  });
}
