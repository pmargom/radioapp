import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radioapp/domain/entities/radio_station_entity.dart';

class RadioStationController {
  late RadioStationEntity radioStation;
  late StreamController<bool> isPlayingController;
  late StreamController<double> volumeController;
  AudioPlayer player = AudioPlayer();

  RadioStationController(this.radioStation) {
    isPlayingController = StreamController<bool>.broadcast();
    volumeController = StreamController<double>.broadcast();
  }

  void _setListeners() {
    isPlayingController.stream.listen((event) {
      debugPrint("_isPlayingController -> $event");
      if (event) {
        player.play();
      } else {
        player.pause();
      }
    });
  }

  void initPlayer() {
    _setListeners();

    _loadUrl();
  }

  Future<void> _loadUrl() async {
    try {
      await player.setPitch(1.0);
      await player.setAudioSource(
        AudioSource.uri(
          Uri.parse(radioStation.urlResolved),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  void play() {
    isPlayingController.add(true);
  }

  void pause() {
    isPlayingController.add(false);
  }

  void close() {
    isPlayingController.close();
    volumeController.close();
  }

  void chnageVolume(double volume) {
    volumeController.add(volume);
    player.setVolume(volume);
    print(volume);
  }
}
