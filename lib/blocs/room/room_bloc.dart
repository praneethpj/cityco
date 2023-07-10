import 'package:cityco/data/repositories/room_repository.dart';
import 'package:cityco/models/room_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository roomRepository;
  RoomBloc({required this.roomRepository}) : super(RoomInitiate()) {
    on<RoomFetchAll>((event, state) async {
      try {
        roomRepository
            .getAllBooking()
            .then((roomModel) => emit(RoomLoaded(roomModel: roomModel)));
      } catch (e) {
        emit(RoomError(message: e.toString()));
      }
    });
  }
}
