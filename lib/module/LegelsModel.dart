
import 'dart:convert';

LegelsModel legelsModelFromJson(String str) => LegelsModel.fromJson(json.decode(str));

String legelsModelToJson(LegelsModel data) => json.encode(data.toJson());

class LegelsModel {
  LegelsModel({
    this.status,
    this.message,
    this.legal,
  });

  int status;
  String message;
  List<Legal> legal;

  factory LegelsModel.fromJson(Map<String, dynamic> json) => LegelsModel(
    status: json["Status"],
    message: json["Message"],
    legal: List<Legal>.from(json["Legal"].map((x) => Legal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Legal": List<dynamic>.from(legal.map((x) => x.toJson())),
  };
}

class Legal {
  Legal({
    this.id,
    this.description,
  });

  int id;
  String description;

  factory Legal.fromJson(Map<String, dynamic> json) => Legal(
    id: json["ID"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Description": description,
  };
}
