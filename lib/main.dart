import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'features/auth/data/data_sources/local_data_source.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/data/repository/register_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/repository/register_repository.dart';
import 'features/auth/domain/use_cases/login_use_case.dart';
import 'features/auth/domain/use_cases/register_use_case.dart';
import 'features/auth/presentation/view/register/register_view.dart';
import 'features/auth/presentation/view/login/login_view.dart';
import 'features/auth/presentation/view_model/login/auth_bloc.dart';
import 'features/onboarding/presentation/view/onboarding_view.dart';
import 'features/splash/presentation/view/splash_view.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide AuthLocalDataSource
        Provider<AuthLocalDataSource>(
          create: (context) => AuthLocalDataSource(),
        ),
        // Provide AuthRepositoryImpl
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            authLocalDataSource: context.read<AuthLocalDataSource>(),
          ),
        ),
        // Provide RegisterRepositoryImpl
        Provider<RegisterRepository>(
          create: (context) => RegisterRepositoryImpl(
            authLocalDataSource: context.read<AuthLocalDataSource>(),
          ),
        ),
        // Provide LoginUseCase
        Provider<LoginUseCase>(
          create: (context) => LoginUseCase(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        // Provide RegisterUseCase
        Provider<RegisterUseCase>(
          create: (context) => RegisterUseCase(
            authRepository: context.read<AuthRepository>(),
            registerRepository: context.read<RegisterRepository>(),
          ),
        ),
        // Provide LoginBloc
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            loginUseCase: context.read<LoginUseCase>(), authRepository: context.read<AuthRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Furniture Shop',
        initialRoute: '/splash',
        debugShowCheckedModeBanner: false,
        routes: {
          '/splash': (context) => const SplashView(),
          '/onboarding': (context) => OnboardingView(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterPage(),
        },
        theme: getApplicationTheme(),
        home: const SplashView(),
      ),
    );
  }
}
