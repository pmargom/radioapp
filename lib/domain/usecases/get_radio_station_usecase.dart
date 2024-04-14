import 'package:dartz/dartz.dart';
import 'package:radioapp/core/errors/server_failure.dart';
import 'package:radioapp/domain/entities/radio_station_entity.dart';
import 'package:radioapp/domain/repositories/radio_stations_repository.dart';

class GetRadioStationUsecase {
  final RadioStationsRepository _repository;

  GetRadioStationUsecase(this._repository);

  Future<Either<Failure, List<RadioStationEntity>>> call(String stationUUID) async {
    return await _repository.getRadioStationByUUID(stationUUID);
  }
}
