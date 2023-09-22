import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_login/blocs/authentication_bloc.dart';
import 'package:flutter_bloc_firebase_login/events/authentication_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is homepage'),
        actions: [
          IconButton(
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationIsLoggedOut());
                print('Logout !!!');
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(child: Text('This is homepage !')),
    );
  }
}
