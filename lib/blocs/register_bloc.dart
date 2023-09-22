import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_login/events/register_event.dart';
import 'package:flutter_bloc_firebase_login/repositories/user_repositories.dart';
import 'package:flutter_bloc_firebase_login/state/register_state.dart';
import 'package:flutter_bloc_firebase_login/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepositories? _userRepositories;
  RegisterBloc({required UserRepositories userRepositories})
      : super(RegisterState.initial()) {
    _userRepositories = userRepositories;
    on<RegisterEvent>(
      (registerEvent, emit) async {
        final registerState = state;
        if (registerEvent is RegisterEventEmailChange) {
          emit(registerState.cloneAndUpdate(
              isValidEmail: Validators.isValidEmail(registerEvent.email!)));
        } else if (registerEvent is RegisterEventPasswordChange) {
          emit(registerState.cloneAndUpdate(
              isValidPassword:
                  Validators.isValidPassword(registerEvent.password!)));
        } else if (registerEvent is RegisterEventWithEmailAndPasswordPressed) {
          try {
            print('Register');
            RegisterState.isLoading();
            await _userRepositories!.createUserWithEmailAndPassword(
                email: registerEvent.email, password: registerEvent.password);
            emit(RegisterState.isSuccess());
          } catch (_) {
            emit(RegisterState.isFailure());
          }
        }
      },
      // transformer: (registerEvents, mapper) {
      //   final debounceStream = registerEvents
      //       .where((event) =>
      //           (event is RegisterEventEmailChange) ||
      //           (event is RegisterEventPasswordChange))
      //       .debounceTime(const Duration(microseconds: 300));
      //   final nonDebounceStream = registerEvents.where((event) =>
      //       (event is! RegisterEventEmailChange) ||
      //       (event is! RegisterEventPasswordChange));
      //   return nonDebounceStream.mergeWith([debounceStream]);
      // }
    );
  }
}
