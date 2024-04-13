import 'package:get_it/get_it.dart';
import 'package:radioapp/data/datasources/remote_data_source.dart';
import 'package:radioapp/data/datasources/remote_data_source_impl.dart';
import 'package:radioapp/data/network/services_base_api.dart';
import 'package:radioapp/data/repositories/radio_stations_repository_impl.dart';
import 'package:radioapp/domain/repositories/radio_stations_repository.dart';
import 'package:radioapp/domain/usecases/get_radio_station_usecase.dart';
import 'package:radioapp/presentation/bloc/radio_stations/radio_stations_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Bloc
  getIt.registerFactory(() => RadioStationsCubit(getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetRadioStationsUsecase(getIt()));

  // Repositories
  getIt.registerLazySingleton<RadioStationsRepository>(() => RadioStationsRepositoryImpl(getIt()));

  // Data sources
  getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(getIt()));

  // Api service
  getIt.registerLazySingleton(() => ServicesBaseApi());
}
