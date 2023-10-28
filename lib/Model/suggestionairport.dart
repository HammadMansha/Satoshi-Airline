// To parse this JSON data, do
//
//     final cityAirport = cityAirportFromJson(jsonString);

import 'dart:convert';

CityAirport cityAirportFromJson(String str) => CityAirport.fromJson(json.decode(str));

String cityAirportToJson(CityAirport data) => json.encode(data.toJson());

class CityAirport {
    String? id;
    String? placeName;
    List<Nearby>? nearby;

    CityAirport({
        this.id,
        this.placeName,
        this.nearby,
    });

    factory CityAirport.fromJson(Map<String, dynamic> json) => CityAirport(
        id: json["id"],
        placeName: json["place_name"],
        nearby: json["nearby"] == null ? [] : List<Nearby>.from(json["nearby"]!.map((x) => Nearby.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "place_name": placeName,
        "nearby": nearby == null ? [] : List<dynamic>.from(nearby!.map((x) => x.toJson())),
    };
}

class Nearby {
    String? cityCode;
    String? countryCode;
    String? iata;
    String? name;
    double? lat;
    double? lon;
    String? country;
    String? cityName;
    double? distance;

    Nearby({
        this.cityCode,
        this.countryCode,
        this.iata,
        this.name,
        this.lat,
        this.lon,
        this.country,
        this.cityName,
        this.distance,
    });

    factory Nearby.fromJson(Map<String, dynamic> json) => Nearby(
        cityCode: json["city_code"],
        countryCode: json["country_code"],
        iata: json["iata"],
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        country: json["country"],
        cityName: json["city_name"],
        distance: json["distance"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "city_code": cityCode,
        "country_code": countryCode,
        "iata": iata,
        "name": name,
        "lat": lat,
        "lon": lon,
        "country": country,
        "city_name": cityName,
        "distance": distance,
    };
}
