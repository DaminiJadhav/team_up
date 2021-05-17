// To parse this JSON data, do
//
//     final updateEducationModel = updateEducationModelFromJson(jsonString);

import 'dart:convert';

UpdateEducationModel updateEducationModelFromJson(String str) => UpdateEducationModel.fromJson(json.decode(str));

String updateEducationModelToJson(UpdateEducationModel data) => json.encode(data.toJson());

class UpdateEducationModel {
  UpdateEducationModel({
    this.id,
    this.intituteName,
    this.startDate,
    this.endDate,
    this.courseName,
    this.grade,
  });

  String id;
  String intituteName;
  String startDate;
  String endDate;
  String courseName;
  String grade;

  factory UpdateEducationModel.fromJson(Map<String, dynamic> json) => UpdateEducationModel(
    id: json["ID"],
    intituteName: json["IntituteName"],
    startDate: json["StartDate"],
    endDate: json["EndDate"],
    courseName: json["CourseName"],
    grade: json["Grade"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "IntituteName": intituteName,
    "StartDate": startDate,
    "EndDate": endDate,
    "CourseName": courseName,
    "Grade": grade,
  };
}
UpdateEducationResponseModel updateEducationResponseModelFromJson(String str) => UpdateEducationResponseModel.fromJson(json.decode(str));

String updateEducationResponseModelToJson(UpdateEducationResponseModel data) => json.encode(data.toJson());

class UpdateEducationResponseModel {
  UpdateEducationResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory UpdateEducationResponseModel.fromJson(Map<String, dynamic> json) => UpdateEducationResponseModel(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}