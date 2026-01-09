part of "auth_bloc.dart";
//register and logout events

//immmutable class prevent unstability of objects
@immutable
sealed class AuthEvent {}

final class RegisterButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final String description;
  final String address;

  RegisterButtonPressedEvent({
    required this.email,
    required this.password,
    required this.username,
    required this.description,
    required this.address,
  });
}

final class LoginButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPressedEvent({required this.email, required this.password});
}

final class AuthCheckRequestedEvent extends AuthEvent {}

final class LogoutButtonPressedEvent extends AuthEvent {}
