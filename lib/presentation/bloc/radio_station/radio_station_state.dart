part of 'radio_station_cubit.dart';

abstract class RadioStationState {}

class RadioStationInitial extends RadioStationState {}

class RadioStationLoading extends RadioStationState {}

class RadioStationLoaded extends RadioStationState {
  final List<RadioStationEntity> radioStationEntities;

  RadioStationLoaded(this.radioStationEntities);
}

class RadioStationError extends RadioStationState {
  final String message;

  RadioStationError(this.message);
}
