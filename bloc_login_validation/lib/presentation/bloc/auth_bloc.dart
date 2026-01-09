import 'package:bloc_login_validation/data/repositories_imp/firebase_services.dart';
import 'package:bloc_login_validation/domain/entities/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

//bloc for authentication
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  AuthBloc() : super(InitialAuth()) {
    //event trigger when login user
    on<RegisterButtonPressedEvent>(_registerButtonPressedEvent);
    //event trigger when login user (fix comment: previously repeated)
    on<LoginButtonPressedEvent>(_loginButtonPressedEvent);
    //event trigger on app start to check if user is already logged in
    on<AuthCheckRequestedEvent>(_authCheckRequestedEvent);
    //event trigger when logout user
    on<LogoutButtonPressedEvent>(_logoutButtonPressedEvent);
  }

  void _authCheckRequestedEvent(
    AuthCheckRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = await _firebaseServices.getUserDetails();
      // If getUserDetails succeeds (i.e., user is logged in via Firebase Auth), emit success
      emit(SuccsussAuth(user: user));
    } catch (e) {
      // If error (e.g. no user logged in, or no doc found), we stay in InitialAuth or emit it explicitly
      // However, if we are just checking checks, maybe we don't want to emit FailedAuth which shows a snackbar.
      // But for now, if getUserDetails fails, it usually means not logged in or network error.
      // We can just ignore or emit InitialAuth.
      emit(InitialAuth());
    }
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

      UserModel user = await _firebaseServices.saveNewUser(
        email,
        password,
        event.description,
        event.username,
        event.address,
      );

      // Successfully registered
      emit(SuccsussAuth(user: user));
    } catch (e) {
      emit(FailedAuth(response: e.toString()));
    }
  }

  //login event
  void _loginButtonPressedEvent(
    LoginButtonPressedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingAuthIndicator());
    try {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      String email = event.email;
      String password = event.password;

      if (email.isEmpty || password.isEmpty) {
        return emit(FailedAuth(response: "email or password cannot be empty"));
      }
      if (!emailRegex.hasMatch(email)) {
        return emit(FailedAuth(response: "please provide a valid email"));
      }

      await _firebaseServices.singInUser(email, password);
      //fetch user details
      final user = await _firebaseServices.getUserDetails();

      // Successfully logged in
      emit(SuccsussAuth(user: user));
    } catch (e) {
      emit(FailedAuth(response: e.toString()));
    }
  }

  //logout event
  void _logoutButtonPressedEvent(
    LogoutButtonPressedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingAuthIndicator());
    try {
      await _firebaseServices.singOut();
      return emit(InitialAuth());
    } catch (e) {
      emit(FailedAuth(response: e.toString()));
    }
  }
}
