import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';
//bloc for authentication
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuth()) {
    //event trigger when login user
    on<RegisterButtonPressedEvent>(_registerButtonPressedEvent);
    //event trigger when logout user
    on<LogoutButtonPressedEvent>(_logoutButtonPressedEvent);
  }

  //register event
  void _registerButtonPressedEvent(
    RegisterButtonPressedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingAuthIndicator());
    try {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      String email = event.email;
      String password = event.password;
      if (email.isEmpty || password.isEmpty) {
        return emit(FailedAuth(response: "email or password cannot be emapty"));
      }

      if (password.length < 8) {
        return emit(
          FailedAuth(response: "password must be grater than 8 characters"),
        );
      }
      if (!emailRegex.hasMatch(email)) {
        return emit(FailedAuth(response: "please provide a valid email"));
      }
      await Future.delayed(Duration(seconds: 1)).then((value) {
        return emit(SuccsussAuth(userId: "${email}x$password"));
      });
    } catch (e) {
      emit(FailedAuth(response: e.toString()));
    }
  }

  //logout event
  void _logoutButtonPressedEvent(
    LogoutButtonPressedEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(LoadingAuthIndicator());
    try {
      return emit(InitialAuth());
    } catch (e) {
      emit(FailedAuth(response: e.toString()));
    }
  }

  // @override
  // void onChange(Change<AuthState> change) {
  //   // TODO: implement onChange
  //   super.onChange(change);
  //   print("a bloc is changed $change");
  // }

  // @override
  // void onTransition(Transition<AuthEvent, AuthState> transition) {
  //   // TODO: implement onTransition
  //   super.onTransition(transition);
  //   print("transition occured $transition");
  // }
}
