// To parse this JSON data, do
//
//     final leaveProjectRequestModel = leaveProjectRequestModelFromJson(jsonString);

import 'dart:convert';

LeaveProjectRequestModel leaveProjectRequestModelFromJson(String str) =>
    LeaveProjectRequestModel.fromJson(json.decode(str));

String leaveProjectRequestModelToJson(LeaveProjectRequestModel data) =>
    json.encode(data.toJson());

class LeaveProjectRequestModel {
  LeaveProjectRequestModel({
    this.confirmation,
    this.email,
    this.password,
    this.userId,
    this.projectId,
    this.isStd,
  });

  String confirmation;
  String email;
  String password;
  String userId;
  String projectId;
  bool isStd;

  factory LeaveProjectRequestModel.fromJson(Map<String, dynamic> json) =>
      LeaveProjectRequestModel(
        confirmation: json["Confirmation"],
        email: json["Email"],
        password: json["Password"],
        userId: json["UserId"],
        projectId: json["ProjectId"],
        isStd: json["IsStd"],
      );

  Map<String, dynamic> toJson() => {
        "Confirmation": confirmation,
        "Email": email,
        "Password": password,
        "UserId": userId,
        "ProjectId": projectId,
        "IsStd": isStd,
      };
}
LeaveProjectResponseModel leaveProjectResponseModelFromJson(String str) => LeaveProjectResponseModel.fromJson(json.decode(str));

String leaveProjectResponseModelToJson(LeaveProjectResponseModel data) => json.encode(data.toJson());

class LeaveProjectResponseModel {
  LeaveProjectResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory LeaveProjectResponseModel.fromJson(Map<String, dynamic> json) => LeaveProjectResponseModel(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}
