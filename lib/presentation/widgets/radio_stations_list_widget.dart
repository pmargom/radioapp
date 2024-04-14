import 'package:flutter/material.dart';
import 'package:radioapp/domain/entities/radio_station_entity.dart';
import 'package:radioapp/presentation/widgets/radio_stations_item_widget.dart';

class RadioStationsListWidget extends StatelessWidget {
  const RadioStationsListWidget({
    super.key,
    required this.radioStations,
  });
  final List<RadioStationEntity> radioStations;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: radioStations.length,
        itemBuilder: (_, index) {
          final radioStation = radioStations[index];

          return RadioStationItemWidget(radioStation: radioStation);
        },
      ),
    );
  }
}
