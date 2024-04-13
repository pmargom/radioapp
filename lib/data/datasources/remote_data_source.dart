import 'package:radioapp/data/models/radio_station_model.dart';

abstract class RemoteDataSource {
  Future<List<RadioStationModel>> getRadioStations(
    String bycountry, [
    int limit = 50,
    bool hidebroken = true,
  ]);
}
