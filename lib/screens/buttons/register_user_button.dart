import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_login/blocs/authentication_bloc.dart';
import 'package:flutter_bloc_firebase_login/blocs/register_bloc.dart';
import 'package:flutter_bloc_firebase_login/repositories/user_repositories.dart';

import '../register_page.dart';

// ignore: must_be_immutable
class RegisterUserButton extends StatelessWidget {
  UserRepositories userRepositories;
  RegisterUserButton({super.key, required this.userRepositories});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: (() {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return BlocProvider<RegisterBloc>(
                create: (context) =>
                    RegisterBloc(userRepositories: userRepositories),
                child: RegisterPage(userRepositories: userRepositories),
              );
            },
          ));
        }),
        child: const Text('Register Account'),
      ),
    );
  }
}
