part of "auth_bloc.dart";
//register and logout events

//immmutable class prevent unstability of objects
@immutable
sealed class AuthEvent {}

final class RegisterButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterButtonPressedEvent({required this.email, required this.password});
}

final class LogoutButtonPressedEvent extends AuthEvent {}
