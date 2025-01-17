class User {
  final String email;
  final String password;

  User({required this.email, required this.password});

  // You can add methods here if needed for business logic related to the User entity
  bool validatePassword(String inputPassword) {
    return password == inputPassword;
  }
}
