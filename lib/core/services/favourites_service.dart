import 'package:radioapp/core/services/preferences_service.dart';
import 'package:radioapp/domain/entities/radio_station_entity.dart';

class FavouritesService {
  late List<String> _favourites;
  List<String> get favourites => _favourites;

  FavouritesService() {
    _getFavourites();
  }

  Future<void> _getFavourites() async {
    _favourites = await PreferencesService.read("liked");
  }

  bool isFavourite(String radioUUID) {
    final filteredValues = _favourites.where((element) => element == radioUUID).toList();
    return filteredValues.isNotEmpty;
  }

  Future<void> toggleLike(bool value, RadioStationEntity radioStation) async {
    if (value) {
      _favourites.removeWhere((element) => element == radioStation.stationuuid);
      await PreferencesService.save("liked", _favourites);
      return;
    }
    _favourites.add(radioStation.stationuuid);
    await PreferencesService.save("liked", _favourites);
  }
}
