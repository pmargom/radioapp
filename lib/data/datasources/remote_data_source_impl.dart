import 'package:dio/dio.dart';
import 'package:radioapp/core/errors/server_exception.dart';
import 'package:radioapp/data/datasources/remote_data_source.dart';
import 'package:radioapp/data/models/radio_station_model.dart';
import 'package:radioapp/data/network/services_base_api.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final ServicesBaseApi _serviceBaseApi;

  RemoteDataSourceImpl(this._serviceBaseApi);

  @override
  Future<List<RadioStationModel>> getRadioStations(String bycountry, [int limit = 50, bool hidebroken = true]) async {
    List<RadioStationModel> radioStations = [];
    try {
      final Map<String, dynamic> queryParameters = {
        "limit": limit,
        "hidebroken": hidebroken,
      };

      Response? response = await _serviceBaseApi.get("stations/bycountry/$bycountry", queryParameters: queryParameters);

      if (response != null) {
        radioStations = RadioStationModel.fromJsonList(response.data);
        return radioStations;
      }
    } catch (e) {
      throw ServerException();
    }

    return radioStations;
  }

  @override
  Future<List<RadioStationModel>> getRadioStationByUUID(String stationUUID) async {
    List<RadioStationModel> radioStationModels = [];
    try {
      final Map<String, dynamic> queryParameters = {"uuids": stationUUID};

      Response? response = await _serviceBaseApi.get("stations/byuuid", queryParameters: queryParameters);

      if (response != null) {
        radioStationModels = RadioStationModel.fromJsonList(response.data);
      }

      return radioStationModels;
    } catch (e) {
      throw ServerException();
    }
  }
}
