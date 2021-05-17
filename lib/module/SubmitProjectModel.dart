// To parse this JSON data, do
//
//     final submitProjectRequestModel = submitProjectRequestModelFromJson(jsonString);

import 'dart:convert';

SubmitProjectRequestModel submitProjectRequestModelFromJson(String str) =>
    SubmitProjectRequestModel.fromJson(json.decode(str));

String submitProjectRequestModelToJson(SubmitProjectRequestModel data) =>
    json.encode(data.toJson());

class SubmitProjectRequestModel {
  SubmitProjectRequestModel({
    this.projectId,
    this.submittedById,
    this.isStd,
    this.submittedDescription,
    this.submittedLink,
  });

  String projectId;
  String submittedById;
  bool isStd;
  String submittedDescription;
  String submittedLink;

  factory SubmitProjectRequestModel.fromJson(Map<String, dynamic> json) =>
      SubmitProjectRequestModel(
        projectId: json["ProjectId"],
        submittedById: json["SubmittedById"],
        isStd: json["IsStd"],
        submittedDescription: json["SubmittedDescription"],
        submittedLink: json["SubmittedLink"],
      );

  Map<String, dynamic> toJson() => {
        "ProjectId": projectId,
        "SubmittedById": submittedById,
        "IsStd": isStd,
        "SubmittedDescription": submittedDescription,
        "SubmittedLink": submittedLink,
      };
}

SubmitProjectResponseModel submitProjectResponseModelFromJson(String str) =>
    SubmitProjectResponseModel.fromJson(json.decode(str));

String submitProjectResponseModelToJson(SubmitProjectResponseModel data) =>
    json.encode(data.toJson());

class SubmitProjectResponseModel {
  SubmitProjectResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory SubmitProjectResponseModel.fromJson(Map<String, dynamic> json) =>
      SubmitProjectResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
