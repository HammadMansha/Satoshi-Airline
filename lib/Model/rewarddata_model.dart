// To parse this JSON data, do
//
//     final rewardData = rewardDataFromJson(jsonString);

import 'dart:convert';

RewardData rewardDataFromJson(String str) => RewardData.fromJson(json.decode(str));

String rewardDataToJson(RewardData data) => json.encode(data.toJson());

class RewardData {
  String? status;
  TravelRecord? travelRecord;
  RewardDataAttributes? attributes;
  BUrnedToken? rewrdToken;
  BUrnedToken? bUrnedToken;
  String? showableMessage;
  double? totalsap;

  RewardData({
    this.status,
    this.travelRecord,
    this.attributes,
    this.rewrdToken,
    this.bUrnedToken,
    this.showableMessage,
    this.totalsap,
  });

  factory RewardData.fromJson(Map<String, dynamic> json) => RewardData(
    status: json["status"],
    travelRecord: json["travelRecord"] == null ? null : TravelRecord.fromJson(json["travelRecord"]),
    attributes: json["attributes"] == null ? null : RewardDataAttributes.fromJson(json["attributes"]),
    rewrdToken: json["RewrdToken"] == null ? null : BUrnedToken.fromJson(json["RewrdToken"]),
    bUrnedToken: json["BUrnedToken"] == null ? null : BUrnedToken.fromJson(json["BUrnedToken"]),
    showableMessage: json["showableMessage"],
    totalsap: json["totalsap"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "travelRecord": travelRecord?.toJson(),
    "attributes": attributes?.toJson(),
    "RewrdToken": rewrdToken?.toJson(),
    "BUrnedToken": bUrnedToken?.toJson(),
    "showableMessage": showableMessage,
    "totalsap": totalsap,
  };
}

class RewardDataAttributes {
  AttributesAttributes? attributes;
  String? id;
  String? wallet;
  int? tokenId;
  BUrnedToken? totalDistance;
  String? cardType;
  int? cardLevel;
  DateTime? time;
  int? v;

  RewardDataAttributes({
    this.attributes,
    this.id,
    this.wallet,
    this.tokenId,
    this.totalDistance,
    this.cardType,
    this.cardLevel,
    this.time,
    this.v,
  });

  factory RewardDataAttributes.fromJson(Map<String, dynamic> json) => RewardDataAttributes(
    attributes: json["attributes"] == null ? null : AttributesAttributes.fromJson(json["attributes"]),
    id: json["_id"],
    wallet: json["wallet"],
    tokenId: json["token_id"],
    totalDistance: json["totalDistance"] == null ? null : BUrnedToken.fromJson(json["totalDistance"]),
    cardType: json["cardType"],
    cardLevel: json["cardLevel"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes?.toJson(),
    "_id": id,
    "wallet": wallet,
    "token_id": tokenId,
    "totalDistance": totalDistance?.toJson(),
    "cardType": cardType,
    "cardLevel": cardLevel,
    "time": time?.toIso8601String(),
    "__v": v,
  };
}

class AttributesAttributes {
  Durability? fuel;
  Durability? mine;
  Durability? durability;
  Durability? luck;

  AttributesAttributes({
    this.fuel,
    this.mine,
    this.durability,
    this.luck,
  });

  factory AttributesAttributes.fromJson(Map<String, dynamic> json) => AttributesAttributes(
    fuel: json["fuel"] == null ? null : Durability.fromJson(json["fuel"]),
    mine: json["mine"] == null ? null : Durability.fromJson(json["mine"]),
    durability: json["durability"] == null ? null : Durability.fromJson(json["durability"]),
    luck: json["luck"] == null ? null : Durability.fromJson(json["luck"]),
  );

  Map<String, dynamic> toJson() => {
    "fuel": fuel?.toJson(),
    "mine": mine?.toJson(),
    "durability": durability?.toJson(),
    "luck": luck?.toJson(),
  };
}

class Durability {
  double? value;
  double? maxValue;

  Durability({
    this.value,
    this.maxValue,
  });

  factory Durability.fromJson(Map<String, dynamic> json) => Durability(
    value: json["value"]?.toDouble(),
    maxValue: json["maxValue"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "maxValue": maxValue,
  };
}

class BUrnedToken {
  double? numberDecimal;

  BUrnedToken({
    this.numberDecimal,
  });

  factory BUrnedToken.fromJson(Map<String, dynamic> json) => BUrnedToken(
    numberDecimal: json["\u0024numberDecimal"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "\u0024numberDecimal": numberDecimal,
  };
}

class TravelRecord {
  String? wallet;
  int? tokenId;
  String? travelFrom;
  String? travelTo;
  BUrnedToken? distance;
  BUrnedToken? redeemKm;
  String? travelTime;
  DateTime? date;
  String? id;
  int? v;

  TravelRecord({
    this.wallet,
    this.tokenId,
    this.travelFrom,
    this.travelTo,
    this.distance,
    this.redeemKm,
    this.travelTime,
    this.date,
    this.id,
    this.v,
  });

  factory TravelRecord.fromJson(Map<String, dynamic> json) => TravelRecord(
    wallet: json["wallet"],
    tokenId: json["tokenId"],
    travelFrom: json["travel_from"],
    travelTo: json["travel_to"],
    distance: json["distance"] == null ? null : BUrnedToken.fromJson(json["distance"]),
    redeemKm: json["redeem_km"] == null ? null : BUrnedToken.fromJson(json["redeem_km"]),
    travelTime: json["travel_time"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "wallet": wallet,
    "tokenId": tokenId,
    "travel_from": travelFrom,
    "travel_to": travelTo,
    "distance": distance?.toJson(),
    "redeem_km": redeemKm?.toJson(),
    "travel_time": travelTime,
    "date": date?.toIso8601String(),
    "_id": id,
    "__v": v,
  };
}
