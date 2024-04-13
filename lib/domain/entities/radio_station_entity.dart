class RadioStationEntity {
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

  RadioStationEntity({
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
}
