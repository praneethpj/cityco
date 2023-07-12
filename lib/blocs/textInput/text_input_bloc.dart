import 'package:cityco/data/repositories/booking_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'text_input_event.dart';
part 'text_input_state.dart';

class TextInputBloc extends Bloc<TextInputEvent, TextInputState> {
  final BookingRepository bookingRepository;
  TextInputBloc({required this.bookingRepository})
      : super(TextInputStateiniate(text: "")) {
    on<TextInit>((event, state) {
      emit(TextInputStateiniate(text: ""));
    });

    on<TextInputChange>((event, state) {
      bookingRepository.addCustomerName(event.data);
      print(event.data);
      emit(TextInputDataChange(text: event.data));
    });
  }
}
