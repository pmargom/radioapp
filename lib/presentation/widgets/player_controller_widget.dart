import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:radioapp/core/config/colors.dart';
import 'package:radioapp/domain/entities/radio_station_entity.dart';
import 'package:radioapp/presentation/radio_station_controller.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PlayerControllerScreen extends StatefulWidget {
  const PlayerControllerScreen({
    super.key,
    required this.radioStationEntity,
  });
  final RadioStationEntity radioStationEntity;

  @override
  State<PlayerControllerScreen> createState() => _PlayerControllerScreenState();
}

class _PlayerControllerScreenState extends State<PlayerControllerScreen> {
  late RadioStationController _radioStationController;

  @override
  void initState() {
    _radioStationController = RadioStationController(widget.radioStationEntity);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _radioStationController.initPlayer();
    });
    super.initState();
  }

  @override
  void dispose() {
    _radioStationController.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildVolumeControl(),
        const SizedBox(height: 20),
        _buildPlayerControls(),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildVolumeControl() {
    return Stack(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 35),
            width: 270,
            height: 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              image: const DecorationImage(image: AssetImage("assets/images/cover.jpg"), fit: BoxFit.cover),
              color: divColor,
            ),
          ),
        ),
        StreamBuilder<double>(
          stream: _radioStationController.volumeController.stream,
          builder: (context, snapshot) {
            final volume = snapshot.data ?? 0.5;
            return SfRadialGauge(
              animationDuration: 1,
              enableLoadingAnimation: true,
              axes: [
                RadialAxis(
                  useRangeColorForAxis: true,
                  startAngle: 0,
                  endAngle: 180,
                  canRotateLabels: false,
                  interval: 10,
                  isInversed: false,
                  maximum: 1,
                  minimum: 0,
                  showAxisLine: true,
                  showLabels: false,
                  showTicks: true,
                  ranges: [
                    GaugeRange(
                      startValue: 0,
                      endValue: volume,
                      color: primaryColor,
                    )
                  ],
                  pointers: [
                    MarkerPointer(
                      color: primaryColor,
                      value: volume,
                      onValueChanged: _radioStationController.chnageVolume,
                      enableAnimation: true,
                      enableDragging: true,
                      markerType: MarkerType.circle,
                      markerWidth: 20,
                      markerHeight: 20,
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  StreamBuilder<bool> _buildPlayerControls() {
    return StreamBuilder<bool>(
      stream: _radioStationController.isPlayingController.stream,
      builder: (_, snapshot) {
        final isPlaying = snapshot.data ?? false;
        if (isPlaying) {
          return _renderPlayerButton("pause.svg", _radioStationController.pause);
        }
        return _renderPlayerButton("play.svg", _radioStationController.play);
      },
    );
  }

  Widget _renderPlayerButton(String iconName, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/icons/$iconName",
            width: 20,
          ),
        ),
      ),
    );
  }
}
