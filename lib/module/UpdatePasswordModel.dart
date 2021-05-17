import 'dart:convert';

UpdatePasswordRequestModel updatePasswordRequestModelFromJson(String str) =>
    UpdatePasswordRequestModel.fromJson(json.decode(str));

String updatePasswordRequestModelToJson(UpdatePasswordRequestModel data) =>
    json.encode(data.toJson());

class UpdatePasswordRequestModel {
  UpdatePasswordRequestModel({
    this.id,
    this.isStudent,
    this.isorg,
    this.password,
  });

  String id;
  bool isStudent;
  bool isorg;
  String password;

  factory UpdatePasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdatePasswordRequestModel(
        id: json["ID"],
        isStudent: json["IsStudent"],
        isorg: json["Isorg"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "IsStudent": isStudent,
        "Isorg": isorg,
        "password": password,
      };
}

UpdatePasswordResponseModel updatePasswordResponseModelFromJson(String str) =>
    UpdatePasswordResponseModel.fromJson(json.decode(str));

String updatePasswordResponseModelToJson(UpdatePasswordResponseModel data) =>
    json.encode(data.toJson());

class UpdatePasswordResponseModel {
  UpdatePasswordResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory UpdatePasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdatePasswordResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
