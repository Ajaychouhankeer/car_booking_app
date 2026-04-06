abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final Map<String, dynamic> body;

  RegisterEvent(this.body);
}

class LoginEvent extends AuthEvent {
  final Map<String, dynamic> body;

  LoginEvent(this.body);
}

class TogglePasswordVisibilityEvent extends AuthEvent {}
