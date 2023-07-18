class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  @override
  String toString() => "LoginReqest(email: $email, password: $password)";
}

class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String phone;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  String toString() => "RegisterRequest(email: $email, password: $password)";
}
