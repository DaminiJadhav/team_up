// To parse this JSON data, do
//
//     final onGoingProjectModel = onGoingProjectModelFromJson(jsonString);

import 'dart:convert';

OnGoingProjectModel onGoingProjectModelFromJson(String str) =>
    OnGoingProjectModel.fromJson(json.decode(str));

String onGoingProjectModelToJson(OnGoingProjectModel data) =>
    json.encode(data.toJson());

class OnGoingProjectModel {
  OnGoingProjectModel({
    this.status,
    this.message,
    this.project,
  });

  int status;
  String message;
  List<Project> project;

  factory OnGoingProjectModel.fromJson(Map<String, dynamic> json) =>
      OnGoingProjectModel(
        status: json["Status"],
        message: json["Message"],
        project:
            List<Project>.from(json["Project"].map((x) => Project.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Project": List<dynamic>.from(project.map((x) => x.toJson())),
      };
}

class Project {
  Project({
    this.id,
    this.projectname,
    this.levels,
    this.endDate,
    this.description,
    this.type,
    this.field,
  });
  int id;
  String projectname;
  String levels;
  String endDate;
  String description;
  String type;
  String field;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
       id: json["ID"],
        projectname: json["Projectname"],
        levels: json["Levels"],
        endDate: json["EndDate"],
        description: json["Description"],
        type: json["Type"],
        field: json["Field"],
      );

  Map<String, dynamic> toJson() => {
        "ID" : id,
        "Projectname": projectname,
        "Levels": levels,
        "EndDate": endDate,
        "Description": description,
        "Type": type,
        "Field": field,
      };
}
