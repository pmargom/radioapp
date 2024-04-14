import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radioapp/domain/entities/radio_station_entity.dart';
import 'package:radioapp/domain/usecases/get_radio_station_usecase.dart';

part 'radio_station_state.dart';

class RadioStationCubit extends Cubit<RadioStationState> {
  final GetRadioStationUsecase _getRadioStationUsecase;

  RadioStationCubit(this._getRadioStationUsecase) : super(RadioStationInitial());

  Future<void> getRadioStation(String stationUUID) async {
    emit(RadioStationLoading());
    final failureOrData = await _getRadioStationUsecase(stationUUID);
    failureOrData.fold(
      (failure) => emit(RadioStationError(failure.toString())),
      (radioStations) => emit(RadioStationLoaded(radioStations)),
    );
  }
}
