part of 'text_input_bloc.dart';

abstract class TextInputState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TextInputStateiniate extends TextInputState {
  String text;
  TextInputStateiniate({required this.text});
}

class TextInputDataChange extends TextInputState {
  String text;
  TextInputDataChange({required this.text});
}
