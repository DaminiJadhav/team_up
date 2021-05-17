import 'dart:convert';

AddEducationRequestModel addEducationRequestModelFromJson(String str) =>
    AddEducationRequestModel.fromJson(json.decode(str));

String addEducationRequestModelToJson(AddEducationRequestModel data) =>
    json.encode(data.toJson());

class AddEducationRequestModel {
  AddEducationRequestModel({
    this.stdId,
    this.facultyId,
    this.courseName,
    this.intituteName,
    this.grade,
    this.startDate,
    this.endDate,
  });

  String stdId;
  String facultyId;
  String courseName;
  String intituteName;
  String grade;
  String startDate;
  String endDate;

  factory AddEducationRequestModel.fromJson(Map<String, dynamic> json) =>
      AddEducationRequestModel(
        stdId: json["StdId"],
        facultyId: json["FacultyId"],
        courseName: json["CourseName"],
        intituteName: json["IntituteName"],
        grade: json["Grade"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
      );

  Map<String, dynamic> toJson() => {
        "StdId": stdId,
        "FacultyId": facultyId,
        "CourseName": courseName,
        "IntituteName": intituteName,
        "Grade": grade,
        "StartDate": startDate,
        "EndDate": endDate,
      };
}

AddEducationResponseModel addEducationResponseModelFromJson(String str) =>
    AddEducationResponseModel.fromJson(json.decode(str));

String addEducationResponseModelToJson(AddEducationResponseModel data) =>
    json.encode(data.toJson());

class AddEducationResponseModel {
  AddEducationResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory AddEducationResponseModel.fromJson(Map<String, dynamic> json) =>
      AddEducationResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
