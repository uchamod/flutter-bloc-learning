part of "auth_bloc.dart";

@immutable
sealed class AuthEvent {}

final class RegisterButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterButtonPressedEvent({required this.email, required this.password});
}

final class LogoutButtonPressedEvent extends AuthEvent {}
