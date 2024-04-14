import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:radioapp/core/config/colors.dart';
import 'package:radioapp/core/services/favourites_service.dart';
import 'package:radioapp/domain/entities/radio_station_entity.dart';
import 'package:radioapp/injection_container.dart';
import 'package:radioapp/presentation/bloc/radio_station/radio_station_cubit.dart';
import 'package:radioapp/presentation/radio_station_controller.dart';
import 'package:radioapp/presentation/widgets/player_controller_widget.dart';
import 'package:radioapp/presentation/widgets/custom_error_widget.dart';
import 'package:radioapp/presentation/widgets/no_data_widget.dart';

class RadioStationDetails extends StatefulWidget {
  const RadioStationDetails({
    super.key,
    required this.stationUUID,
  });
  final String stationUUID;

  @override
  State<RadioStationDetails> createState() => _RadioStationDetailsState();
}

class _RadioStationDetailsState extends State<RadioStationDetails> {
  late FavouritesService _favouritesService;
  late RadioStationController _radioStationController;
  late StreamController<bool> _togleController;

  @override
  void initState() {
    super.initState();
    _favouritesService = getIt<FavouritesService>();
    _togleController = StreamController.broadcast();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadRadioStation(widget.stationUUID);
    });
  }

  @override
  void dispose() {
    _togleController.close();
    _radioStationController.close();
    super.dispose();
  }

  void _loadRadioStation(String stationUUID) {
    BlocProvider.of<RadioStationCubit>(context).getRadioStation(stationUUID);
    Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDataConsumer(),
      ],
    );
  }

  Widget _buildDataConsumer() {
    return BlocConsumer<RadioStationCubit, RadioStationState>(
      listener: (_, state) {
        if (state is RadioStationInitial) {
          return;
        }
        if (state is RadioStationError) {
          return;
        }
        if (state is RadioStationLoading) {
          return;
        }
        if (state is RadioStationLoaded) {
          // if (state.radioStationEntity != null) {
          //   _streamController.add(state.radioStationEntity!);
          // }
          return;
        }
      },
      builder: (context, state) {
        if (state is RadioStationInitial) {
          return const SizedBox();
        }

        if (state is RadioStationError) {
          return CustomErrorWidget(message: state.message);
        }

        if (state is RadioStationLoaded) {
          final List<RadioStationEntity> radioStation = state.radioStationEntities;

          if (radioStation.isEmpty) {
            return const NoDataWidget(message: "Radio station not found");
          }

          return _buildRadioStationDetails(context, radioStation.first);
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildRadioStationDetails(BuildContext context, RadioStationEntity radioStation) {
    _radioStationController = RadioStationController(radioStation);
    _radioStationController.initPlayer();

    final isFavourite = _favouritesService.isFavourite(radioStation.stationuuid);
    _togleController.add(isFavourite);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icons/play_outline.svg"),
              const SizedBox(width: 10),
              Text(
                "${radioStation.votes} votes",
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  radioStation.name,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              StreamBuilder<bool>(
                stream: _togleController.stream,
                initialData: isFavourite,
                builder: (_, snapshot) {
                  final newValue = snapshot.data ?? false;
                  return GestureDetector(
                    onTap: () {
                      _favouritesService.toggleLike(newValue, radioStation);
                      _togleController.add(!newValue);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/heart.svg",
                      color: newValue ? primaryColor : Colors.white,
                      width: 25,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                radioStation.country,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 10),
          PlayerControllerScreen(radioStationEntity: radioStation),
        ],
      ),
    );
  }
}
