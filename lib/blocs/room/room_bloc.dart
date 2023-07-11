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
        roomRepository.getAllRooms().then((roomModel) => {
              if (roomModel.isNotEmpty)
                {emit(RoomLoaded(roomModel: roomModel))}
              else
                {emit(RoomEmpty())}
            });
      } catch (e) {
        emit(RoomError(message: e.toString()));
      }
    });

    on<RoomGetByDocumentId>((event, state) async {
      try {
        roomRepository.getRoomByDocumentId(event.documentId).then((roomModel) =>
            emit(RoomGetByDocumentIdRequest(roomModel: roomModel)));
      } catch (e) {
        emit(RoomError(message: e.toString()));
      }
    });
  }
}
