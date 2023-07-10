import 'package:cityco/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<SignUpRequested>((event, state) async {
      emit(Loading());
      try {
        authRepository.signUp();
        emit(Authenticated());
      } catch (e) {
        emit(UnAuthenticated());
      }
    });
  }
}
