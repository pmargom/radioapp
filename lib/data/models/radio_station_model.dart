import 'package:radioapp/domain/entities/radio_station_entity.dart';

class RadioStationModel {
  String stationuuid;
  String name;
  String url;
  String urlResolved;
  String homepage;
  String favicon;
  String tags;
  String country;
  String countrycode;
  String state;
  String language;
  int votes;
  String codec;
  int bitrate;
  double? geoLat;
  double? geoLong;
  bool hasExtendedInfo;

  RadioStationModel({
    required this.stationuuid,
    required this.name,
    required this.url,
    required this.urlResolved,
    required this.homepage,
    required this.favicon,
    required this.tags,
    required this.country,
    required this.countrycode,
    required this.state,
    required this.language,
    required this.votes,
    required this.codec,
    required this.bitrate,
    required this.geoLat,
    required this.geoLong,
    required this.hasExtendedInfo,
  });

  RadioStationModel copyWith({
    String? stationuuid,
    String? name,
    String? url,
    String? urlResolved,
    String? homepage,
    String? favicon,
    String? tags,
    String? country,
    String? countrycode,
    String? state,
    String? language,
    int? votes,
    String? codec,
    int? bitrate,
    double? geoLat,
    double? geoLong,
    bool? hasExtendedInfo,
  }) =>
      RadioStationModel(
        stationuuid: stationuuid ?? this.stationuuid,
        name: name ?? this.name,
        url: url ?? this.url,
        urlResolved: urlResolved ?? this.urlResolved,
        homepage: homepage ?? this.homepage,
        favicon: favicon ?? this.favicon,
        tags: tags ?? this.tags,
        country: country ?? this.country,
        countrycode: countrycode ?? this.countrycode,
        state: state ?? this.state,
        language: language ?? this.language,
        votes: votes ?? this.votes,
        codec: codec ?? this.codec,
        bitrate: bitrate ?? this.bitrate,
        geoLat: geoLat ?? this.geoLat,
        geoLong: geoLong ?? this.geoLong,
        hasExtendedInfo: hasExtendedInfo ?? this.hasExtendedInfo,
      );

  static RadioStationModel fromJson(json) {
    return RadioStationModel(
      stationuuid: json["stationuuid"],
      name: json["name"],
      url: json["url"],
      urlResolved: json["url_resolved"],
      homepage: json["homepage"],
      favicon: json["favicon"],
      tags: json["tags"],
      country: json["country"],
      countrycode: json["countrycode"],
      state: json["state"],
      language: json["language"],
      votes: json["votes"],
      codec: json["codec"],
      bitrate: json["bitrate"],
      geoLat: json["geo_lat"],
      geoLong: json["geo_long"],
      hasExtendedInfo: json["has_extended_info"],
    );
  }

  static List<RadioStationModel> fromJsonList(List json) => List<RadioStationModel>.from(json.map((json) => RadioStationModel.fromJson(json)));
}

extension RadioStationExtension on RadioStationModel {
  RadioStationEntity get asEntity => RadioStationEntity(
        stationuuid: stationuuid,
        name: name,
        url: url,
        urlResolved: urlResolved,
        homepage: homepage,
        favicon: favicon,
        tags: tags,
        country: country,
        countrycode: countrycode,
        state: state,
        language: language,
        votes: votes,
        codec: codec,
        bitrate: bitrate,
        geoLat: geoLat,
        geoLong: geoLong,
        hasExtendedInfo: hasExtendedInfo,
      );
}
