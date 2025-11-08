part of "auth_bloc.dart";

@immutable
sealed class AuthState {}

final class InitialAuth extends AuthState {}

final class SuccsussAuth extends AuthState {
  final String userId; //user model data

  SuccsussAuth({required this.userId});
}

final class FailedAuth extends AuthState {
  final String response;

  FailedAuth({required this.response});
}

final class LoadingAuthIndicator extends AuthState {}
