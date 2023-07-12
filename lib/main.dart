import 'package:cityco/blocs/authentication/auth_bloc.dart';
import 'package:cityco/blocs/booking/booking_bloc.dart';
import 'package:cityco/blocs/textInput/text_input_bloc.dart';
import 'package:cityco/data/repositories/auth_repository.dart';
import 'package:cityco/data/repositories/booking_repository.dart';
import 'package:cityco/data/repositories/room_repository.dart';
import 'package:cityco/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/room/room_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => RoomRepository(),
        ),
        RepositoryProvider(
          create: (context) => BookingRepository(),
        )
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context)),
        ),
        BlocProvider(
            create: (context) => RoomBloc(
                bookingRepository:
                    RepositoryProvider.of<BookingRepository>(context),
                roomRepository: RepositoryProvider.of<RoomRepository>(context))
              ..add(RoomFetchAll())),
        BlocProvider(
            create: (context) => BookingBloc(
                bookingRepository:
                    RepositoryProvider.of<BookingRepository>(context))
              ..add(BookingIniateEvent())),
        BlocProvider(
            create: (context) => TextInputBloc(
                bookingRepository:
                    RepositoryProvider.of<BookingRepository>(context))
              ..add(TextInit())),
      ], child: Home())));
}
