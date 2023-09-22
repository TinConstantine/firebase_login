import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_login/blocs/authentication_bloc.dart';
import 'package:flutter_bloc_firebase_login/blocs/register_bloc.dart';
import 'package:flutter_bloc_firebase_login/events/authentication_event.dart';
import 'package:flutter_bloc_firebase_login/events/register_event.dart';
import 'package:flutter_bloc_firebase_login/repositories/user_repositories.dart';

import 'package:flutter_bloc_firebase_login/screens/buttons/register_button.dart';
import 'package:flutter_bloc_firebase_login/screens/buttons/register_user_button.dart';

import 'package:flutter_bloc_firebase_login/state/register_state.dart';

class RegisterPage extends StatefulWidget {
  final UserRepositories userRepositories;
  const RegisterPage({super.key, required this.userRepositories});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late RegisterBloc _registerBloc;
  UserRepositories get _userRepoistories => widget.userRepositories;
  @override
  void initState() {
    super.initState();
    _registerBloc = context.read<RegisterBloc>();
    _emailController.addListener(() {
      _registerBloc.add(RegisterEventEmailChange(email: _emailController.text));
    });
    _passwordController.addListener(() {
      _registerBloc
          .add(RegisterEventPasswordChange(password: _passwordController.text));
    });
  }

  bool get isPopulate =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isRegisterButtonEnable(RegisterState registerState) {
    return isPopulate &&
        registerState.isValidEmailAndPassword &&
        registerState.isSubmitting;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, registerState) {
        if (registerState.isFailure) {
          print('Register failed');
        } else if (registerState.isSubmitting) {
          print('Register submitting');
        } else if (registerState.isSuccess) {
          print('Register success');
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
                  return registerState.isValidEmail
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
                  return registerState.isValidPassword
                      ? null
                      : 'Invalid password format';
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: isRegisterButtonEnable(registerState)
                    ? RegisterButton(onpress: _onLoginEmailAndPassword())
                    : null,
              ),
              const SizedBox(
                height: 10,
              ),
              RegisterButton(onpress: () {
                context.read<RegisterBloc>().add(
                    RegisterEventWithEmailAndPasswordPressed(
                        email: _emailController.text,
                        password: _passwordController.text));

                print('Register account');
              })
            ],
          )),
        );
      }),
    );
  }

  _onLoginEmailAndPassword() {
    _registerBloc.add(RegisterEventWithEmailAndPasswordPressed(
        email: _emailController.text, password: _passwordController.text));
    Navigator.of(context).pop();
  }
}
