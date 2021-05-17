import 'dart:convert';

CloseAccountRequestModel closeAccountRequestModelFromJson(String str) =>
    CloseAccountRequestModel.fromJson(json.decode(str));

String closeAccountRequestModelToJson(CloseAccountRequestModel data) =>
    json.encode(data.toJson());

class CloseAccountRequestModel {
  CloseAccountRequestModel({
    this.id,
    this.isStudent,
    this.isOrg,
    this.email,
    this.password,
    this.reason,
  });

  int id;
  bool isStudent;
  bool isOrg;
  String email;
  String password;
  String reason;

  factory CloseAccountRequestModel.fromJson(Map<String, dynamic> json) =>
      CloseAccountRequestModel(
        id: json["Id"],
        isStudent: json["IsStudent"],
        isOrg: json["IsOrg"],
        email: json["email"],
        password: json["password"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "IsStudent": isStudent,
        "IsOrg": isOrg,
        "email": email,
        "password": password,
        "reason": reason,
      };
}

CloseAccountResponseModel closeAccountResponseModelFromJson(String str) =>
    CloseAccountResponseModel.fromJson(json.decode(str));

String closeAccountResponseModelToJson(CloseAccountResponseModel data) =>
    json.encode(data.toJson());

class CloseAccountResponseModel {
  CloseAccountResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory CloseAccountResponseModel.fromJson(Map<String, dynamic> json) =>
      CloseAccountResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
