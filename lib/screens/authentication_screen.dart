import 'package:cityco/blocs/authentication/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Loading) {
            return CircularProgressIndicator();
          } else if (state is Authenticated) {
            Future.delayed(Duration.zero, () {
              Navigator.pushReplacementNamed(context, "/home");
            });
            return CircularProgressIndicator();
          } else {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignUpRequested());
                      },
                      child: Text("Sign In")),
                ],
              ),
            );
          }
        },
      )),
    );
  }
}
