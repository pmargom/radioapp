import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radioapp/domain/entities/radio_station_entity.dart';
import 'package:radioapp/domain/usecases/get_radio_station_usecase.dart';

part 'radio_stations_state.dart';

class RadioStationsCubit extends Cubit<RadioStationsState> {
  final GetRadioStationsUsecase _getRadioStationsUsecase;

  RadioStationsCubit(this._getRadioStationsUsecase) : super(RadioStationsInitial());

  Future<void> getRadioStations(String bycountry) async {
    emit(RadioStationsLoading());
    final failureOrData = await _getRadioStationsUsecase(bycountry);
    failureOrData.fold(
      (failure) => emit(RadioStationsError(failure.toString())),
      (radioStations) => emit(RadioStationsLoaded(radioStations)),
    );
  }
}
