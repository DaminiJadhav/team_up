// To parse this JSON data, do
//
//     final sProjectLevelModel = sProjectLevelModelFromJson(jsonString);

import 'dart:convert';

SProjectLevelModel sProjectLevelModelFromJson(String str) =>
    SProjectLevelModel.fromJson(json.decode(str));

String sProjectLevelModelToJson(SProjectLevelModel data) =>
    json.encode(data.toJson());

class SProjectLevelModel {
  SProjectLevelModel({
    this.status,
    this.message,
    this.projectTypes,
  });

  int status;
  String message;
  List<LevelsType> projectTypes;

  factory SProjectLevelModel.fromJson(Map<String, dynamic> json) =>
      SProjectLevelModel(
        status: json["Status"],
        message: json["Message"],
        projectTypes: List<LevelsType>.from(
            json["ProjectTypes"].map((x) => LevelsType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "ProjectTypes": List<dynamic>.from(projectTypes.map((x) => x.toJson())),
      };
}

class LevelsType {
  LevelsType({
    this.id,
    this.lavelName,
  });

  int id;
  String lavelName;

  factory LevelsType.fromJson(Map<String, dynamic> json) => LevelsType(
        id: json["ID"],
        lavelName: json["LavelName"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "LavelName": lavelName,
      };
}
