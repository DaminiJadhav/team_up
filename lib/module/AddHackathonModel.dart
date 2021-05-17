import 'dart:convert';

AddHackathonRequestModel addHackathonRequestModelFromJson(String str) =>
    AddHackathonRequestModel.fromJson(json.decode(str));

String addHackathonRequestModelToJson(AddHackathonRequestModel data) =>
    json.encode(data.toJson());

class AddHackathonRequestModel {
  AddHackathonRequestModel({
    this.hackathonName,
    this.description,
    this.startDate,
    this.endDate,
    this.website,
    this.noOfProblemStatement,
    this.orgId,
    this.winningPrice,
    this.contactNo,
  });

  String hackathonName;
  String description;
  DateTime startDate;
  DateTime endDate;
  String website;
  String noOfProblemStatement;
  int orgId;
  String winningPrice;
  String contactNo;

  factory AddHackathonRequestModel.fromJson(Map<String, dynamic> json) =>
      AddHackathonRequestModel(
        hackathonName: json["HackathonName"],
        description: json["Description"],
        startDate: DateTime.parse(json["StartDate"]),
        endDate: DateTime.parse(json["EndDate"]),
        website: json["Website"],
        noOfProblemStatement: json["NoOfProblemStatement"],
        orgId: json["OrgId"],
        winningPrice: json["WinningPrice"],
        contactNo: json["ContactNo"],
      );

  Map<String, dynamic> toJson() => {
        "HackathonName": hackathonName,
        "Description": description,
        "StartDate": startDate.toIso8601String(),
        "EndDate": endDate.toIso8601String(),
        "Website": website,
        "NoOfProblemStatement": noOfProblemStatement,
        "OrgId": orgId,
        "WinningPrice": winningPrice,
        "ContactNo": contactNo,
      };
}

AddHackathonResponseModel addHackathonResponseModelFromJson(String str) =>
    AddHackathonResponseModel.fromJson(json.decode(str));

String addHackathonResponseModelToJson(AddHackathonResponseModel data) =>
    json.encode(data.toJson());

class AddHackathonResponseModel {
  AddHackathonResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory AddHackathonResponseModel.fromJson(Map<String, dynamic> json) =>
      AddHackathonResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
