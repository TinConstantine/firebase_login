import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_login/events/authentication_event.dart';
import 'package:flutter_bloc_firebase_login/repositories/user_repositories.dart';
import 'package:flutter_bloc_firebase_login/state/authetication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepositories? _userReositories;
  AuthenticationBloc({required UserRepositories userRepositories})
      : super(AuthenticationStateInitial()) {
    // assert(_userReositories != null);

    // ignore: unrelated_type_equality_checks

    _userReositories = userRepositories;
    // ignore: unrelated_type_equality_checks
    on<AuthenticationEvent>((authenticationEvent, emit) async {
      if (authenticationEvent is AuthenticationStarted) {
        final isSignedIn = _userReositories!.isSignedIn();
        print('isSignIn: $isSignedIn');
        if (isSignedIn) {
          final firebaseUser = _userReositories!.getUser();
          emit(AuthenticationStateSuccess(firebaseUser: firebaseUser!));
        } else {
          emit(AuthenticationStateFailure());
        }
      } else if (authenticationEvent is AuthenticationIsLoggedIn) {
        print('Login sucess');
        final user = _userReositories!.getUser();
        emit(AuthenticationStateSuccess(firebaseUser: user!));
      } else if (authenticationEvent is AuthenticationIsLoggedOut) {
        _userReositories!.signOut();
        emit(AuthenticationStateFailure());
      }
    });
  }
}
