import 'package:cityco/blocs/authentication/auth_bloc.dart';
import 'package:cityco/blocs/room/room_bloc.dart';
import 'package:cityco/data/repositories/auth_repository.dart';
import 'package:cityco/data/repositories/room_repository.dart';
import 'package:cityco/screens/authentication_screen.dart';
import 'package:cityco/screens/home_screen.dart';
import 'package:cityco/screens/product_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CityCo (Pvt) Ltd",
      theme: ThemeData(),
      initialRoute: "/",
      routes: {
        "/": (context) => AuthenticationScreen(),
        "/home": (context) => HomeScreen(),
        "/product": (context) => ProductDescription()
      },
    );
  }
}
