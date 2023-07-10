import 'package:cityco/blocs/authentication/auth_bloc.dart';
import 'package:cityco/blocs/room/room_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is RoomLoading) {
            return CircularProgressIndicator();
          } else if (state is RoomLoaded) {
            return Row(
              children: [
                Text("Booking Count ${state.roomModel.length}"),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: state.roomModel.length,
                  itemBuilder: (context, index) {
                    final room = state.roomModel[index];
                    return GridTile(
                      child: Text(room.name),
                    );
                  },
                )
              ],
            );
          } else {
            return Text("Home");
          }
        },
      )),
    );
  }
}
