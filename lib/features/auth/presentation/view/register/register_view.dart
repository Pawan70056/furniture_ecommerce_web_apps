import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funiture_ecommerce/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:funiture_ecommerce/features/auth/presentation/view_model/register/register_event.dart';
import 'package:funiture_ecommerce/features/auth/presentation/view_model/register/register_state.dart';
import 'package:funiture_ecommerce/features/auth/domain/use_cases/register_use_case.dart'; // RegisterUseCase import
import 'package:funiture_ecommerce/features/auth/domain/repository/auth_repository.dart'; // AuthRepository import

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        registerUseCase: context.read<RegisterUseCase>(),
        authRepository: context.read<AuthRepository>(), // Provide authRepository
      ),
      child: const _RegisterPageBody(),
    );
  }
}

class _RegisterPageBody extends StatefulWidget {
  const _RegisterPageBody({Key? key}) : super(key: key);

  @override
  _RegisterPageBodyState createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<_RegisterPageBody> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  state is RegisterLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final username = _usernameController.text;
                        final password = _passwordController.text;
                        final confirmPassword =
                            _confirmPasswordController.text;

                        // Trigger registration event
                        context.read<RegisterBloc>().add(
                          SubmitRegistration(
                            username,
                            password,
                            confirmPassword,
                          ),
                        );
                      }
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
