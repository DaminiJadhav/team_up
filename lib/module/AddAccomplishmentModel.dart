import 'dart:convert';

AddAccomplishmentRequestModel addAccomplishmentRequestModelFromJson(
        String str) =>
    AddAccomplishmentRequestModel.fromJson(json.decode(str));

String addAccomplishmentRequestModelToJson(
        AddAccomplishmentRequestModel data) =>
    json.encode(data.toJson());

class AddAccomplishmentRequestModel {
  AddAccomplishmentRequestModel({
    this.stdId,
    this.facultyId,
    this.name,
    this.issuedAuthorityName,
    this.issuedDate,
  });

  String stdId;
  String facultyId;
  String name;
  String issuedAuthorityName;
  String issuedDate;

  factory AddAccomplishmentRequestModel.fromJson(Map<String, dynamic> json) =>
      AddAccomplishmentRequestModel(
        stdId: json["StdId"],
        facultyId: json["FacultyId"],
        name: json["Name"],
        issuedAuthorityName: json["IssuedAuthorityName"],
        issuedDate: json["IssuedDate"],
      );

  Map<String, dynamic> toJson() => {
        "StdId": stdId,
        "FacultyId": facultyId,
        "Name": name,
        "IssuedAuthorityName": issuedAuthorityName,
        "IssuedDate": issuedDate,
      };
}

AddAccomplishmentResponseModel addAccomplishmentResponseModelFromJson(
        String str) =>
    AddAccomplishmentResponseModel.fromJson(json.decode(str));

String addAccomplishmentResponseModelToJson(
        AddAccomplishmentResponseModel data) =>
    json.encode(data.toJson());

class AddAccomplishmentResponseModel {
  AddAccomplishmentResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory AddAccomplishmentResponseModel.fromJson(Map<String, dynamic> json) =>
      AddAccomplishmentResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
