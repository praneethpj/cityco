part of 'text_input_bloc.dart';

abstract class TextInputEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TextInit extends TextInputEvent {}

class TextInputChange extends TextInputEvent {
  final String data;
  TextInputChange({required this.data});
}
