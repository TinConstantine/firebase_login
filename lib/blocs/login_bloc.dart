import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_login/events/login_event.dart';
import 'package:flutter_bloc_firebase_login/repositories/user_repositories.dart';
import 'package:flutter_bloc_firebase_login/state/login_state.dart';
import 'package:flutter_bloc_firebase_login/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepositories? _userRepositories;
  LoginBloc({required UserRepositories userRepositories})
      : super(LoginState.initial()) {
    _userRepositories = userRepositories;
    on<LoginEvent>(
      (loginEvent, emit) async {
        final loginState = state;
        if (loginEvent is LoginEventEmailChange) {
          emit(loginState.cloneAndUpdate(
              isValidEmail: Validators.isValidEmail(loginEvent.email!)));
        } else if (loginEvent is LoginEventPasswordChange) {
          emit(loginState.cloneAndUpdate(
              isValidPassword:
                  Validators.isValidPassword(loginEvent.password!)));
        } else if (loginEvent is LoginEventWithEmailAndPasswordPressed) {
          try {
            emit(LoginState.isLoading());
            await _userRepositories!.signInWithEmailAndPassword(
                email: loginEvent.email, password: loginEvent.password);
            print('LoginBloc: Login success');
            emit(LoginState.isSuccess());
          } catch (_) {
            emit(LoginState.isFailure());
          }
        } else if (loginEvent is LoginEventWithGooglePressed) {
          try {
            await _userRepositories!.signInWithGoogle();
            emit(LoginState.isSuccess());
          } catch (_) {
            emit(LoginState.isFailure());
          }
        }
      },
      /*transformer: (loginEvents, mapper) {
      final debounceStream = loginEvents
          .where((event) =>
              (loginEvents is LoginEventEmailChange) ||
              (loginEvents is LoginEventPasswordChange))
          .debounceTime(const Duration(microseconds: 300));
      final nonDebounceStream = loginEvents.where((event) =>
          (loginEvents is! LoginEventEmailChange) ||
          (loginEvents is! LoginEventPasswordChange));
      return nonDebounceStream.mergeWith([debounceStream]);
    }*/
    );
  }
}
