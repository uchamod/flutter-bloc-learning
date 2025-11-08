part of "auth_bloc.dart";
//auth state that sit in authentication process

//immmutable class prevent unstability of objects
@immutable
sealed class AuthState {}

//initial state nothing happen
final class InitialAuth extends AuthState {}

//succsuss state
final class SuccsussAuth extends AuthState {
  final String userId; //user model data

  SuccsussAuth({required this.userId});
}

//fail state
final class FailedAuth extends AuthState {
  final String response;

  FailedAuth({required this.response});
}

//loading state
final class LoadingAuthIndicator extends AuthState {}
