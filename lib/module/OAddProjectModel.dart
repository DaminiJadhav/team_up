// To parse this JSON data, do
//
//     final oAddProjectRequestModel = oAddProjectRequestModelFromJson(jsonString);

import 'dart:convert';

OAddProjectRequestModel oAddProjectRequestModelFromJson(String str) =>
    OAddProjectRequestModel.fromJson(json.decode(str));

String oAddProjectRequestModelToJson(OAddProjectRequestModel data) =>
    json.encode(data.toJson());

class OAddProjectRequestModel {
  OAddProjectRequestModel({
    this.orgId,
    this.projectname,
    this.projectheading,
    this.type,
    this.levels,
    this.field,
    this.description,
    this.projectTags,
    this.teamMembers,
    this.endDate,
    this.typeOfpeople,
    this.isReview,
    this.amount,
  });

  String orgId;
  String projectname;
  String projectheading;
  String type;
  String levels;
  String field;
  String description;
  String projectTags;
  String teamMembers;
  String endDate;
  String typeOfpeople;
  String isReview;
  String amount;

  factory OAddProjectRequestModel.fromJson(Map<String, dynamic> json) =>
      OAddProjectRequestModel(
        orgId: json["OrgId"],
        projectname: json["Projectname"],
        projectheading: json["Projectheading"],
        type: json["Type"],
        levels: json["Levels"],
        field: json["Field"],
        description: json["Description"],
        projectTags: json["ProjectTags"],
        teamMembers: json["TeamMembers"],
        endDate: json["EndDate"],
        typeOfpeople: json["TypeOfpeople"],
        isReview: json["IsReview"],
        amount: json["Amount"],
      );

  Map<String, dynamic> toJson() => {
        "OrgId": orgId,
        "Projectname": projectname,
        "Projectheading": projectheading,
        "Type": type,
        "Levels": levels,
        "Field": field,
        "Description": description,
        "ProjectTags": projectTags,
        "TeamMembers": teamMembers,
        "EndDate": endDate,
        "TypeOfpeople": typeOfpeople,
        "IsReview": isReview,
        "Amount": amount,
      };
}

OAddProjectResponseModel oAddProjectResponseModelFromJson(String str) =>
    OAddProjectResponseModel.fromJson(json.decode(str));

String oAddProjectResponseModelToJson(OAddProjectResponseModel data) =>
    json.encode(data.toJson());

class OAddProjectResponseModel {
  OAddProjectResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory OAddProjectResponseModel.fromJson(Map<String, dynamic> json) =>
      OAddProjectResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
