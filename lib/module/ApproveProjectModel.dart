// To parse this JSON data, do
//
//     final approveProjectRequestModel = approveProjectRequestModelFromJson(jsonString);

import 'dart:convert';

ApproveProjectRequestModel approveProjectRequestModelFromJson(String str) =>
    ApproveProjectRequestModel.fromJson(json.decode(str));

String approveProjectRequestModelToJson(ApproveProjectRequestModel data) =>
    json.encode(data.toJson());

class ApproveProjectRequestModel {
  ApproveProjectRequestModel({
    this.projectId,
    this.userId,
    this.isAdmin,
  });

  String projectId;
  String userId;
  bool isAdmin;

  factory ApproveProjectRequestModel.fromJson(Map<String, dynamic> json) =>
      ApproveProjectRequestModel(
        projectId: json["ProjectId"],
        userId: json["UserId"],
        isAdmin: json["IsAdmin"],
      );

  Map<String, dynamic> toJson() => {
        "ProjectId": projectId,
        "UserId": userId,
        "IsAdmin": isAdmin,
      };
}

ApproveProjectResponseModel approveProjectResponseModelFromJson(String str) =>
    ApproveProjectResponseModel.fromJson(json.decode(str));

String approveProjectResponseModelToJson(ApproveProjectResponseModel data) =>
    json.encode(data.toJson());

class ApproveProjectResponseModel {
  ApproveProjectResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory ApproveProjectResponseModel.fromJson(Map<String, dynamic> json) =>
      ApproveProjectResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
