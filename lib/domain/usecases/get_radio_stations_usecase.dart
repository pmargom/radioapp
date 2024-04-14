import 'package:dartz/dartz.dart';
import 'package:radioapp/core/errors/server_failure.dart';
import 'package:radioapp/domain/entities/radio_station_entity.dart';
import 'package:radioapp/domain/repositories/radio_stations_repository.dart';

class GetRadioStationsUsecase {
  final RadioStationsRepository _repository;

  GetRadioStationsUsecase(this._repository);

  Future<Either<Failure, List<RadioStationEntity>>> call(String bycountry) async {
    return await _repository.getRadioStations(bycountry);
  }
}
