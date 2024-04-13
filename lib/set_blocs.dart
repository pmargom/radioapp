import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radioapp/injection_container.dart';
import 'package:radioapp/presentation/bloc/radio_stations/radio_stations_cubit.dart';

final blocList = [
  BlocProvider(create: (_) => getIt<RadioStationsCubit>()),
];
