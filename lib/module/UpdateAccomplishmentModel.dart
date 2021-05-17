import 'dart:convert';

UpdateAccomplishmentModel updateAccomplishmentModelFromJson(String str) =>
    UpdateAccomplishmentModel.fromJson(json.decode(str));

String updateAccomplishmentModelToJson(UpdateAccomplishmentModel data) =>
    json.encode(data.toJson());

class UpdateAccomplishmentModel {
  UpdateAccomplishmentModel({
    this.id,
    this.name,
    this.issuedAuthorityName,
    this.issuedDate,
  });

  String id;
  String name;
  String issuedAuthorityName;
  String issuedDate;

  factory UpdateAccomplishmentModel.fromJson(Map<String, dynamic> json) =>
      UpdateAccomplishmentModel(
        id: json["ID"],
        name: json["Name"],
        issuedAuthorityName: json["IssuedAuthorityName"],
        issuedDate: json["IssuedDate"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "IssuedAuthorityName": issuedAuthorityName,
        "IssuedDate": issuedDate,
      };
}
UpdateAccomplishmentResponseModel updateAccomplishmentResponseModelFromJson(String str) => UpdateAccomplishmentResponseModel.fromJson(json.decode(str));

String updateAccomplishmentResponseModelToJson(UpdateAccomplishmentResponseModel data) => json.encode(data.toJson());

class UpdateAccomplishmentResponseModel {
  UpdateAccomplishmentResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory UpdateAccomplishmentResponseModel.fromJson(Map<String, dynamic> json) => UpdateAccomplishmentResponseModel(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}

