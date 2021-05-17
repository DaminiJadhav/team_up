// To parse this JSON data, do
//
//     final rejectProjectRequestModel = rejectProjectRequestModelFromJson(jsonString);

import 'dart:convert';

RejectProjectRequestModel rejectProjectRequestModelFromJson(String str) => RejectProjectRequestModel.fromJson(json.decode(str));

String rejectProjectRequestModelToJson(RejectProjectRequestModel data) => json.encode(data.toJson());

class RejectProjectRequestModel {
  RejectProjectRequestModel({
    this.projectId,
    this.userId,
    this.isAdmin,
    this.rejectReason,
  });

  String projectId;
  String userId;
  bool isAdmin;
  String rejectReason;

  factory RejectProjectRequestModel.fromJson(Map<String, dynamic> json) => RejectProjectRequestModel(
    projectId: json["ProjectId"],
    userId: json["UserId"],
    isAdmin: json["IsAdmin"],
    rejectReason: json["RejectReason"],
  );

  Map<String, dynamic> toJson() => {
    "ProjectId": projectId,
    "UserId": userId,
    "IsAdmin": isAdmin,
    "RejectReason": rejectReason,
  };
}
RejectProjectResponseModel rejectProjectResponseModelFromJson(String str) => RejectProjectResponseModel.fromJson(json.decode(str));

String rejectProjectResponseModelToJson(RejectProjectResponseModel data) => json.encode(data.toJson());

class RejectProjectResponseModel {
  RejectProjectResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory RejectProjectResponseModel.fromJson(Map<String, dynamic> json) => RejectProjectResponseModel(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}
