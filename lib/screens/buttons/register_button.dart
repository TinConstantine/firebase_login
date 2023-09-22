import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegisterButton extends StatelessWidget {
  void Function()? onpress;
  RegisterButton({super.key, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        height: 45,
        child: ElevatedButton(
          onPressed: onpress,
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
          child: const Text('Register'),
        ));
  }
}
