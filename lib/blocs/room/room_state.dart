part of 'room_bloc.dart';

abstract class RoomState extends Equatable {
  @override
  List<RoomModel> get props => [];
}

class RoomInitiate extends RoomState {
  @override
  List<RoomModel> get props => [];
}

class RoomEmpty extends RoomState {
  @override
  List<RoomModel> get props => [];
}

class RoomGetByDocumentIdRequest extends RoomState {
  final RoomModel roomModel;
  RoomGetByDocumentIdRequest({required this.roomModel});
}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  final List<RoomModel> roomModel;
  RoomLoaded({required this.roomModel});
}

class RoomError extends RoomState {
  final String message;
  RoomError({required this.message});
}
