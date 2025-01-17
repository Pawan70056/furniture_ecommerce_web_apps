// register_event.dart
abstract class RegisterEvent {}

class SubmitRegistration extends RegisterEvent {
  final String email;
  final String password;
  final String confirmPassword;

  SubmitRegistration(this.email, this.password, this.confirmPassword);
}
