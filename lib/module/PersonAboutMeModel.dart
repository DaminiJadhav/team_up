// To parse this JSON data, do
//
//     final personAboutMeModel = personAboutMeModelFromJson(jsonString);

import 'dart:convert';

PersonAboutMeRequestModel personAboutMeModelFromJson(String str) =>
    PersonAboutMeRequestModel.fromJson(json.decode(str));

String personAboutMeModelToJson(PersonAboutMeRequestModel data) =>
    json.encode(data.toJson());

class PersonAboutMeRequestModel {
  PersonAboutMeRequestModel({
    this.isStudent,
    this.isfaculty,
    this.isorg,
    this.id,
    this.aboutMyself,
  });

  bool isStudent;
  String isfaculty;
  String isorg;
  int id;
  String aboutMyself;

  factory PersonAboutMeRequestModel.fromJson(Map<String, dynamic> json) =>
      PersonAboutMeRequestModel(
        isStudent: json["IsStudent"],
        isfaculty: json["Isfaculty"],
        isorg: json["Isorg"],
        id: json["ID"],
        aboutMyself: json["About_myself"],
      );

  Map<String, dynamic> toJson() => {
        "IsStudent": isStudent,
        "Isfaculty": isfaculty,
        "Isorg": isorg,
        "ID": id,
        "About_myself": aboutMyself,
      };
}

PersonAboutMeResponseModel personAboutMeResponseModelFromJson(String str) =>
    PersonAboutMeResponseModel.fromJson(json.decode(str));

String personAboutMeResponseModelToJson(PersonAboutMeResponseModel data) =>
    json.encode(data.toJson());

class PersonAboutMeResponseModel {
  PersonAboutMeResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory PersonAboutMeResponseModel.fromJson(Map<String, dynamic> json) =>
      PersonAboutMeResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
