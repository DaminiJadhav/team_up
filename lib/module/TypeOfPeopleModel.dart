// To parse this JSON data, do
//
//     final typeOfPeopleModel = typeOfPeopleModelFromJson(jsonString);

import 'dart:convert';

TypeOfPeopleModel typeOfPeopleModelFromJson(String str) => TypeOfPeopleModel.fromJson(json.decode(str));

String typeOfPeopleModelToJson(TypeOfPeopleModel data) => json.encode(data.toJson());

class TypeOfPeopleModel {
  TypeOfPeopleModel({
    this.status,
    this.message,
    this.peopleTypes,
  });

  int status;
  String message;
  List<PeopleType> peopleTypes;

  factory TypeOfPeopleModel.fromJson(Map<String, dynamic> json) => TypeOfPeopleModel(
    status: json["Status"],
    message: json["Message"],
    peopleTypes: List<PeopleType>.from(json["PeopleTypes"].map((x) => PeopleType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "PeopleTypes": List<dynamic>.from(peopleTypes.map((x) => x.toJson())),
  };
}

class PeopleType {
  PeopleType({
    this.id,
    this.roleName,
  });

  int id;
  String roleName;

  factory PeopleType.fromJson(Map<String, dynamic> json) => PeopleType(
    id: json["ID"],
    roleName: json["RoleName"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "RoleName": roleName,
  };
}