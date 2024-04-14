import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radioapp/core/config/colors.dart';
import 'package:radioapp/presentation/bloc/radio_stations/radio_stations_cubit.dart';
import 'package:radioapp/presentation/widgets/loading_widget.dart';
import 'package:radioapp/presentation/widgets/no_data_widget.dart';
import 'package:radioapp/presentation/widgets/radio_stations_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _loadRadioStations() {
    BlocProvider.of<RadioStationsCubit>(context).getRadioStations("Spain");
  }

  @override
  Widget build(BuildContext context) {
    _loadRadioStations();
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildMainContent(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("Radio Stations"),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 300,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(image: AssetImage("assets/images/cover.jpg"), fit: BoxFit.cover),
                    color: divColor,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: _buildRenderData(),
        ),
      ],
    );
  }

  BlocConsumer<RadioStationsCubit, RadioStationsState> _buildRenderData() {
    return BlocConsumer<RadioStationsCubit, RadioStationsState>(
      listener: (context, state) {
        if (state is RadioStationsInitial) {
          return;
        }
        if (state is RadioStationsLoading) {
          return;
        }
        if (state is RadioStationsError) {
          return;
        }
        if (state is RadioStationsLoaded) {
          return;
        }
      },
      builder: (context, state) {
        if (state is RadioStationsInitial) {
          return const SizedBox();
        }

        if (state is RadioStationsLoading) {
          return const LoadingWidget();
        }

        if (state is RadioStationsError) {
          return ErrorWidget(state.message);
        }

        if (state is RadioStationsLoaded) {
          final radioStations = state.radioStationEntities;
          if (radioStations.isEmpty) {
            return Column(
              children: [
                const SizedBox(height: 40),
                const NoDataWidget(message: "No results"),
                IconButton(
                  onPressed: _loadRadioStations,
                  icon: const Icon(
                    Icons.refresh_outlined,
                  ),
                ),
              ],
            );
          }
          return RadioStationsListWidget(radioStations: radioStations);
        }

        return const SizedBox();
      },
    );
  }
}
