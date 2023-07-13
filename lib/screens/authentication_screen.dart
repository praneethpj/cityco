import 'package:cityco/blocs/authentication/auth_bloc.dart';
import 'package:cityco/configurations/app_color.dart';
import 'package:cityco/screens/home_screen.dart';
import 'package:cityco/widgets/customized_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../configurations/app_constant.dart';

class AuthenticationScreen extends StatelessWidget {
  static const String routeName = "/auth";
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Loading) {
            return const CustomizedCircularIndicator();
          } else if (state is Authenticated) {
            Future.delayed(Duration.zero, () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            });
            return const CustomizedCircularIndicator();
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: _deviceSize.width / 5,
                      height: _deviceSize.height / 5,
                    ),
                  ),
                  Center(
                      child: Text(
                    appName,
                    style: GoogleFonts.aBeeZee(
                        color: mainTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(SignUpRequested());
                          },
                          child: SizedBox(
                            width: _deviceSize.width * 0.5,
                            child: Center(
                              child: Text(
                                "Sign In",
                                style: GoogleFonts.abel(fontSize: 20),
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      )),
    );
  }
}
