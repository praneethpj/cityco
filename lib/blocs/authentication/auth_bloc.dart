import 'package:cityco/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<AuthInitEvent>((event, state) async {
      authRepository.isUserLoggedIn().then((isLogin) =>
          isLogin ? emit(Authenticated()) : emit(UnAuthenticated()));
    });

    on<SignUpRequested>((event, state) async {
      emit(Loading());
      try {
        authRepository.signUp();
        emit(Authenticated());
      } catch (e) {
        emit(UnAuthenticated());
      }
    });

    on<SignOutUser>((event, state) async {
      authRepository.setUserSignOut();
      try {
        emit(AuthSignOut());
      } catch (e) {}
    });
  }
}
