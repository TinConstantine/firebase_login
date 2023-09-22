import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_login/blocs/login_bloc.dart';
import 'package:flutter_bloc_firebase_login/events/login_event.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        height: 45,
        child: IconButton(
            onPressed: () {
              context.read<LoginBloc>().add(LoginEventWithGooglePressed());
            },
            icon: const Icon(
              FontAwesomeIcons.google,
              size: 17,
            )));
  }
}
