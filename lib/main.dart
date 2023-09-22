import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_login/blocs/authentication_bloc.dart';
import 'package:flutter_bloc_firebase_login/blocs/login_bloc.dart';
import 'package:flutter_bloc_firebase_login/blocs/simple_bloc_observer.dart';
import 'package:flutter_bloc_firebase_login/events/authentication_event.dart';
import 'package:flutter_bloc_firebase_login/screens/home_page.dart';
import 'package:flutter_bloc_firebase_login/screens/login_page.dart';
import 'package:flutter_bloc_firebase_login/screens/splash_page.dart';
import 'package:flutter_bloc_firebase_login/state/authetication_state.dart';
import 'firebase_options.dart';

import 'repositories/user_repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final userRepositories = UserRepositories();

  // userRepositories.createUserWithEmailAndPassword(
  //     email: 'kendytin0@gmail.com', password: '123456');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _userRepositories = UserRepositories();

  @override
  Widget build(BuildContext context) {
    print(_userRepositories.toString());
    return BlocProvider<AuthenticationBloc>(
      create: (context) =>
          AuthenticationBloc(userRepositories: _userRepositories)
            ..add(AuthenticationStarted()),
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authenticationState) {
            print('AuthenticationSate: $authenticationState');
            if (authenticationState is AuthenticationStateSuccess) {
              print('Main: Sucess');
              return const HomePage();
            } else if (authenticationState is AuthenticationStateFailure) {
              return BlocProvider<LoginBloc>(
                create: (context) =>
                    LoginBloc(userRepositories: _userRepositories),
                child: LoginPage(
                  userRepositories: _userRepositories,
                ),
              );
            }
            return const SplashPage();
          },
        ),
      ),
    );
  }
}
