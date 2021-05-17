import 'dart:convert';

AddExperienceRequestModel addExperienceRequestModelFromJson(String str) =>
    AddExperienceRequestModel.fromJson(json.decode(str));

String addExperienceRequestModelToJson(AddExperienceRequestModel data) =>
    json.encode(data.toJson());

class AddExperienceRequestModel {
  AddExperienceRequestModel({
    this.stdId,
    this.facultyId,
    this.companyName,
    this.address,
    this.yourRole,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.description,
  });

  String stdId;
  String facultyId;
  String companyName;
  String address;
  String yourRole;
  String startDate;
  String endDate;
  bool isCurrent;
  String description;

  factory AddExperienceRequestModel.fromJson(Map<String, dynamic> json) =>
      AddExperienceRequestModel(
        stdId: json["StdId"],
        facultyId: json["FacultyId"],
        companyName: json["CompanyName"],
        address: json["Address"],
        yourRole: json["YourRole"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        isCurrent: json["IsCurrent"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "StdId": stdId,
        "FacultyId": facultyId,
        "CompanyName": companyName,
        "Address": address,
        "YourRole": yourRole,
        "StartDate": startDate,
        "EndDate": endDate,
        "IsCurrent": isCurrent,
        "Description": description,
      };
}

AddExperienceResponseModel addExperienceResponseModelFromJson(String str) =>
    AddExperienceResponseModel.fromJson(json.decode(str));

String addExperienceResponseModelToJson(AddExperienceResponseModel data) =>
    json.encode(data.toJson());

class AddExperienceResponseModel {
  AddExperienceResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory AddExperienceResponseModel.fromJson(Map<String, dynamic> json) =>
      AddExperienceResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
