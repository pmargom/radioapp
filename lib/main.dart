import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radioapp/core/config/theme.dart';
import 'package:radioapp/injection_container.dart';
import 'package:radioapp/app_router.dart';
import 'package:radioapp/presentation/bloc/radio_station/radio_station_cubit.dart';
import 'package:radioapp/presentation/bloc/radio_stations/radio_stations_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // providers: blocList,
      providers: [
        BlocProvider(create: (_) => getIt<RadioStationsCubit>()),
        BlocProvider(create: (_) => getIt<RadioStationCubit>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Radio Station',
        theme: darkTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
