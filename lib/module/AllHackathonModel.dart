import 'dart:convert';

AllHackathonModel allHackathonModelFromJson(String str) =>
    AllHackathonModel.fromJson(json.decode(str));

String allHackathonModelToJson(AllHackathonModel data) =>
    json.encode(data.toJson());

class AllHackathonModel {
  AllHackathonModel({
    this.status,
    this.message,
    this.hackathonList,
  });

  int status;
  String message;
  List<HackathonList> hackathonList;

  factory AllHackathonModel.fromJson(Map<String, dynamic> json) =>
      AllHackathonModel(
        status: json["Status"],
        message: json["Message"],
        hackathonList: List<HackathonList>.from(
            json["HackathonList"].map((x) => HackathonList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "HackathonList":
            List<dynamic>.from(hackathonList.map((x) => x.toJson())),
      };
}

class HackathonList {
  HackathonList({
    this.hackathonId,
    this.hackathonName,
    this.lastDate,
    this.winningPrice,
    this.contactNo,
    this.problemStatementCount,
    this.registeredTeamCount,
  });

  int hackathonId;
  String hackathonName;
  String lastDate;
  String winningPrice;
  String contactNo;
  int problemStatementCount;
  int registeredTeamCount;

  factory HackathonList.fromJson(Map<String, dynamic> json) => HackathonList(
        hackathonId: json["HackathonId"],
        hackathonName: json["HackathonName"],
        lastDate: json["LastDate"],
        winningPrice: json["WinningPrice"],
        contactNo: json["ContactNo"],
        problemStatementCount: json["ProblemStatementCount"],
        registeredTeamCount: json["RegisteredTeamCount"],
      );

  Map<String, dynamic> toJson() => {
        "HackathonId": hackathonId,
        "HackathonName": hackathonName,
        "LastDate": lastDate,
        "WinningPrice": winningPrice,
        "ContactNo": contactNo,
        "ProblemStatementCount": problemStatementCount,
        "RegisteredTeamCount": registeredTeamCount,
      };
}
