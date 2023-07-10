import 'package:cityco/blocs/authentication/auth_bloc.dart';
import 'package:cityco/blocs/room/room_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<RoomBloc, RoomState>(
      builder: (context, state) {
        if (state is RoomLoading) {
          return CircularProgressIndicator();
        } else {
          return Container(
            child: Text("Home"),
          );
        }
      },
      listener: (context, state) {},
    ));
  }
}
