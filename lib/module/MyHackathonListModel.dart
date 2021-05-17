// To parse this JSON data, do
//
//     final myHackathonListModel = myHackathonListModelFromJson(jsonString);

import 'dart:convert';

MyHackathonListModel myHackathonListModelFromJson(String str) =>
    MyHackathonListModel.fromJson(json.decode(str));

String myHackathonListModelToJson(MyHackathonListModel data) =>
    json.encode(data.toJson());

class MyHackathonListModel {
  MyHackathonListModel({
    this.status,
    this.message,
    this.listOfMyHackathon,
  });

  int status;
  String message;
  List<ListOfMyHackathon> listOfMyHackathon;

  factory MyHackathonListModel.fromJson(Map<String, dynamic> json) =>
      MyHackathonListModel(
        status: json["Status"],
        message: json["Message"],
        listOfMyHackathon: List<ListOfMyHackathon>.from(
            json["ListOfMyHackathon"]
                .map((x) => ListOfMyHackathon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "ListOfMyHackathon":
            List<dynamic>.from(listOfMyHackathon.map((x) => x.toJson())),
      };
}

class ListOfMyHackathon {
  ListOfMyHackathon({
    this.hackathonName,
    this.hackathonId,
    this.lastDate,
    this.problemStatementCount,
    this.registeredTeamCount,
    this.winningPrice,
  });

  String hackathonName;
  int hackathonId;
  String lastDate;
  int problemStatementCount;
  int registeredTeamCount;
  String winningPrice;

  factory ListOfMyHackathon.fromJson(Map<String, dynamic> json) =>
      ListOfMyHackathon(
        hackathonName: json["HackathonName"],
        hackathonId: json["HackathonId"],
        lastDate: json["LastDate"],
        problemStatementCount: json["ProblemStatementCount"],
        registeredTeamCount: json["RegisteredTeamCount"],
        winningPrice: json["WinningPrice"],
      );

  Map<String, dynamic> toJson() => {
        "HackathonName": hackathonName,
        "HackathonId": hackathonId,
        "LastDate": lastDate,
        "ProblemStatementCount": problemStatementCount,
        "RegisteredTeamCount": registeredTeamCount,
    "WinningPrice":winningPrice,
      };
}
