import 'dart:convert';

ChangeNameRequestModel changeNameRequestModelFromJson(String str) =>
    ChangeNameRequestModel.fromJson(json.decode(str));

String changeNameRequestModelToJson(ChangeNameRequestModel data) =>
    json.encode(data.toJson());

class ChangeNameRequestModel {
  ChangeNameRequestModel({
    this.id,
    this.isStudent,
    this.isOrg,
    this.firstname,
    this.lastname,
    this.orgname,
  });

  int id;
  bool isStudent;
  bool isOrg;
  String firstname;
  String lastname;
  String orgname;

  factory ChangeNameRequestModel.fromJson(Map<String, dynamic> json) =>
      ChangeNameRequestModel(
        id: json["Id"],
        isStudent: json["IsStudent"],
        isOrg: json["IsOrg"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        orgname: json["orgname"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "IsStudent": isStudent,
        "IsOrg": isOrg,
        "firstname": firstname,
        "lastname": lastname,
        "orgname": orgname,
      };
}

ChangeEmailIdRequestModel changeEmailIdRequestModelFromJson(String str) =>
    ChangeEmailIdRequestModel.fromJson(json.decode(str));

String changeEmailIdRequestModelToJson(ChangeEmailIdRequestModel data) =>
    json.encode(data.toJson());

class ChangeEmailIdRequestModel {
  ChangeEmailIdRequestModel({
    this.email,
    this.id,
    this.isStudent,
    this.isOrg,
  });

  String email;
  int id;
  bool isStudent;
  bool isOrg;

  factory ChangeEmailIdRequestModel.fromJson(Map<String, dynamic> json) =>
      ChangeEmailIdRequestModel(
        email: json["email"],
        id: json["Id"],
        isStudent: json["IsStudent"],
        isOrg: json["IsOrg"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "Id": id,
        "IsStudent": isStudent,
        "IsOrg": isOrg,
      };
}

ChangePasswordRequestModel changePasswordRequestModelFromJson(String str) =>
    ChangePasswordRequestModel.fromJson(json.decode(str));

String changePasswordRequestModelToJson(ChangePasswordRequestModel data) =>
    json.encode(data.toJson());

class ChangePasswordRequestModel {
  ChangePasswordRequestModel({
    this.id,
    this.isStudent,
    this.isOrg,
    this.oldpassword,
    this.newpassword,
  });

  int id;
  bool isStudent;
  bool isOrg;
  String oldpassword;
  String newpassword;

  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordRequestModel(
        id: json["Id"],
        isStudent: json["IsStudent"],
        isOrg: json["IsOrg"],
        oldpassword: json["oldpassword"],
        newpassword: json["newpassword"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "IsStudent": isStudent,
        "IsOrg": isOrg,
        "oldpassword": oldpassword,
        "newpassword": newpassword,
      };
}

ChangeResponseModel changeResponseModelFromJson(String str) =>
    ChangeResponseModel.fromJson(json.decode(str));

String changeResponseModelToJson(ChangeResponseModel data) =>
    json.encode(data.toJson());

class ChangeResponseModel {
  ChangeResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory ChangeResponseModel.fromJson(Map<String, dynamic> json) =>
      ChangeResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
