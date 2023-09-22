import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_login/blocs/authentication_bloc.dart';
import 'package:flutter_bloc_firebase_login/events/authentication_event.dart';
import 'package:flutter_bloc_firebase_login/events/login_event.dart';
import 'package:flutter_bloc_firebase_login/repositories/user_repositories.dart';
import 'package:flutter_bloc_firebase_login/screens/buttons/google_login_button.dart';
import 'package:flutter_bloc_firebase_login/screens/buttons/login_button.dart';
import 'package:flutter_bloc_firebase_login/screens/buttons/register_user_button.dart';
import 'package:flutter_bloc_firebase_login/screens/register_page.dart';
import 'package:flutter_bloc_firebase_login/state/login_state.dart';

import '../blocs/login_bloc.dart';
import '../blocs/register_bloc.dart';

class LoginPage extends StatefulWidget {
  final UserRepositories userRepositories;
  const LoginPage({super.key, required this.userRepositories});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late LoginBloc _loginBloc;
  UserRepositories get _userRepoistories => widget.userRepositories;
  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
    _emailController.addListener(() {
      _loginBloc.add(LoginEventEmailChange(email: _emailController.text));
    });
    _passwordController.addListener(() {
      _loginBloc
          .add(LoginEventPasswordChange(password: _passwordController.text));
    });
  }

  bool get isPopulate =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isLoginButtonEnable(LoginState loginState) =>
      loginState.isValidEmailAndPassword &&
      isPopulate &&
      !loginState.isSubmitting;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(builder: (context, loginState) {
        if (loginState.isFailure) {
          print('Login failed');
        } else if (loginState.isSubmitting) {
          print('Login submitting');
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (loginState.isSuccess) {
          print('Login success');
          context.read<AuthenticationBloc>().add(AuthenticationIsLoggedIn());
        }
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
              child: ListView(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.email), labelText: 'Enter Your Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (_) {
                  return loginState.isValidEmail
                      ? null
                      : 'Invalid email format';
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    labelText: 'Enter Your Password'),
                keyboardType: TextInputType.emailAddress,
                validator: (_) {
                  return loginState.isValidPassword
                      ? null
                      : 'Invalid password format';
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    LoginButton(
                        onpress: isLoginButtonEnable(loginState)
                            ? _onLoginEmailAndPassword
                            : null),
                    RegisterUserButton(userRepositories: _userRepoistories),
                    const GoogleLoginButton()
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 20),
              //   child:,
              // ),
            ],
          )),
        );
      }),
    );
  }

  void _onLoginEmailAndPassword() {
    _loginBloc.add(LoginEventWithEmailAndPasswordPressed(
        email: _emailController.text, password: _passwordController.text));
    print('add');
  }
}
