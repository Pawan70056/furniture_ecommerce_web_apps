class Credentials {
  final String email;
  final String password;

  Credentials({required this.email, required this.password});

  // You can add methods here if you need to validate the credentials or do other operations
  bool areValid() {
    return email.isNotEmpty && password.isNotEmpty;
  }
}
