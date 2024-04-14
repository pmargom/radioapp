import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radioapp/presentation/screens/radio_station_details.dart';
import 'package:radioapp/presentation/widgets/app_bar_back_button.dart';

class RadioStationPlayerScreen extends StatefulWidget {
  const RadioStationPlayerScreen({super.key, this.goRouterState});

  final GoRouterState? goRouterState;

  @override
  State<RadioStationPlayerScreen> createState() => _RadioStationPlayerScreenState();
}

class _RadioStationPlayerScreenState extends State<RadioStationPlayerScreen> {
  late String _radioUUID;
  @override
  void initState() {
    super.initState();
    final queryParameters = widget.goRouterState?.uri.queryParameters ?? {};
    _radioUUID = queryParameters["stationuuid"] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const AppBarBackButton(),
              const SizedBox(height: 10),
              const SizedBox(height: 40),
              RadioStationDetails(stationUUID: _radioUUID),
              const SizedBox(height: 10),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
