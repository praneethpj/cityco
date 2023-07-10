part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable {
  @override
  List<RoomModel> get props => [];
}

class RoomSelect extends RoomEvent {
  final String id;
  RoomSelect({required this.id});
}

class RoomFetchAll extends RoomEvent {
  @override
  List<RoomModel> get props => [];
}
