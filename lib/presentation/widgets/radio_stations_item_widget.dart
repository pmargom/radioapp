import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:radioapp/app_router.dart';
import 'package:radioapp/core/config/colors.dart';
import 'package:radioapp/domain/entities/radio_station_entity.dart';

class RadioStationItemWidget extends StatelessWidget {
  const RadioStationItemWidget({
    super.key,
    required this.radioStation,
  });

  final RadioStationEntity radioStation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => _onSelectItem(context),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: divColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  radioStation.name,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset("assets/icons/play.svg"),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectItem(BuildContext context) {
    context.push(Uri(path: Routes.details, queryParameters: {
      "stationuuid": radioStation.stationuuid,
    }).toString());
  }
}
