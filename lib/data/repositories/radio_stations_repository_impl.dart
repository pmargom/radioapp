import 'package:dartz/dartz.dart';
import 'package:radioapp/core/errors/server_failure.dart';
import 'package:radioapp/data/datasources/remote_data_source.dart';
import 'package:radioapp/data/models/radio_station_model.dart';
import 'package:radioapp/domain/entities/radio_station_entity.dart';
import 'package:radioapp/domain/repositories/radio_stations_repository.dart';

class RadioStationsRepositoryImpl implements RadioStationsRepository {
  final RemoteDataSource _remoteDataSource;

  RadioStationsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<RadioStationEntity>>> getRadioStations(String bycountry) async {
    try {
      final List<RadioStationModel> radioStationModels = await _remoteDataSource.getRadioStations(bycountry);

      final List<RadioStationEntity> radioStationEntities =
          radioStationModels.map((RadioStationModel radioStationModel) => radioStationModel.asEntity).toList();
      return Right(radioStationEntities);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
