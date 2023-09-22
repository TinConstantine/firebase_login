import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginButton extends StatelessWidget {
  void Function()? onpress;
  LoginButton({super.key, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        height: 45,
        child: ElevatedButton(
          onPressed: onpress,
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
          child: const Text('Login to your account'),
        ));
  }
}
