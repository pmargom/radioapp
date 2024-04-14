part of 'radio_stations_cubit.dart';

abstract class RadioStationsState {}

class RadioStationsInitial extends RadioStationsState {}

class RadioStationsLoading extends RadioStationsState {}

class RadioStationsLoaded extends RadioStationsState {
  final List<RadioStationEntity> radioStationEntities;

  RadioStationsLoaded(this.radioStationEntities);
}

class RadioStationsError extends RadioStationsState {
  final String message;

  RadioStationsError(this.message);
}
