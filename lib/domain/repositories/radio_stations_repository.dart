import 'package:dartz/dartz.dart';
import 'package:radioapp/core/errors/server_failure.dart';
import 'package:radioapp/domain/entities/radio_station_entity.dart';

abstract class RadioStationsRepository {
  Future<Either<Failure, List<RadioStationEntity>>> getRadioStations(String bycountry);
  Future<Either<Failure, List<RadioStationEntity>>> getRadioStationByUUID(String stationUUID);
}
