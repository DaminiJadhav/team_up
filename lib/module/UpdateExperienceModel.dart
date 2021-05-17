// To parse this JSON data, do
//
//     final updateExperienceModel = updateExperienceModelFromJson(jsonString);

import 'dart:convert';

UpdateExperienceModel updateExperienceModelFromJson(String str) => UpdateExperienceModel.fromJson(json.decode(str));

String updateExperienceModelToJson(UpdateExperienceModel data) => json.encode(data.toJson());

class UpdateExperienceModel {
  UpdateExperienceModel({
    this.id,
    this.companyName,
    this.address,
    this.yourRole,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.description,
  });

  String id;
  String companyName;
  String address;
  String yourRole;
  String startDate;
  String endDate;
  bool isCurrent;
  String description;

  factory UpdateExperienceModel.fromJson(Map<String, dynamic> json) => UpdateExperienceModel(
    id: json["ID"],
    companyName: json["CompanyName"],
    address: json["Address"],
    yourRole: json["YourRole"],
    startDate: json["StartDate"],
    endDate: json["EndDate"],
    isCurrent: json["IsCurrent"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CompanyName": companyName,
    "Address": address,
    "YourRole": yourRole,
    "StartDate": startDate,
    "EndDate": endDate,
    "IsCurrent": isCurrent,
    "Description": description,
  };
}
UpdateExperienceResponseModel updateExperienceResponseModelFromJson(String str) => UpdateExperienceResponseModel.fromJson(json.decode(str));

String updateExperienceResponseModelToJson(UpdateExperienceResponseModel data) => json.encode(data.toJson());

class UpdateExperienceResponseModel {
  UpdateExperienceResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory UpdateExperienceResponseModel.fromJson(Map<String, dynamic> json) => UpdateExperienceResponseModel(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}

