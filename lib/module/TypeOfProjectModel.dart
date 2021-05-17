// To parse this JSON data, do
//
//     final typeOfProjectModel = typeOfProjectModelFromJson(jsonString);

import 'dart:convert';

TypeOfProjectModel typeOfProjectModelFromJson(String str) => TypeOfProjectModel.fromJson(json.decode(str));

String typeOfProjectModelToJson(TypeOfProjectModel data) => json.encode(data.toJson());

class TypeOfProjectModel {
  TypeOfProjectModel({
    this.status,
    this.message,
    this.projectTypes,
  });

  int status;
  String message;
  List<ProjectType> projectTypes;

  factory TypeOfProjectModel.fromJson(Map<String, dynamic> json) => TypeOfProjectModel(
    status: json["Status"],
    message: json["Message"],
    projectTypes: List<ProjectType>.from(json["ProjectTypes"].map((x) => ProjectType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "ProjectTypes": List<dynamic>.from(projectTypes.map((x) => x.toJson())),
  };
}

class ProjectType {
  ProjectType({
    this.id,
    this.typename,
  });

  int id;
  String typename;

  factory ProjectType.fromJson(Map<String, dynamic> json) => ProjectType(
    id: json["ID"],
    typename: json["Typename"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Typename": typename,
  };
}