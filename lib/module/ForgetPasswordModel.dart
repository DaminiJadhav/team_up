import 'dart:convert';

ForgetPasswordRequestModel forgetPasswordRequestModelFromJson(String str) =>
    ForgetPasswordRequestModel.fromJson(json.decode(str));

String forgetPasswordRequestModelToJson(ForgetPasswordRequestModel data) =>
    json.encode(data.toJson());

class ForgetPasswordRequestModel {
  ForgetPasswordRequestModel({
    this.username,
    this.isStudent,
    this.isOrg,
    this.isAdmin,
  });

  String username;
  bool isStudent;
  bool isOrg;
  bool isAdmin;

  factory ForgetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordRequestModel(
        username: json["username"],
        isStudent: json["IsStudent"],
        isOrg: json["IsOrg"],
        isAdmin: json["IsAdmin"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "IsStudent": isStudent,
        "IsOrg": isOrg,
        "IsAdmin": isAdmin,
      };
}

ForgetPasswordResponseModel forgetPasswordResponseModelFromJson(String str) =>
    ForgetPasswordResponseModel.fromJson(json.decode(str));

String forgetPasswordResponseModelToJson(ForgetPasswordResponseModel data) =>
    json.encode(data.toJson());

class ForgetPasswordResponseModel {
  ForgetPasswordResponseModel({
    this.status,
    this.message,
    this.otp,
    this.user,
    this.id,
  });

  int status;
  String message;
  String otp;
  String user;
  int id;

  factory ForgetPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordResponseModel(
        status: json["Status"],
        message: json["Message"],
        otp: json["otp"],
        user: json["User"],
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "otp": otp,
        "User": user,
        "Id": id,
      };
}
