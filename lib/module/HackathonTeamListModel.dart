// To parse this JSON data, do
//
//     final hackathonTeamListModel = hackathonTeamListModelFromJson(jsonString);

import 'dart:convert';

HackathonTeamListModel hackathonTeamListModelFromJson(String str) => HackathonTeamListModel.fromJson(json.decode(str));

String hackathonTeamListModelToJson(HackathonTeamListModel data) => json.encode(data.toJson());

class HackathonTeamListModel {
  HackathonTeamListModel({
    this.status,
    this.message,
    this.teamList,
  });

  int status;
  String message;
  List<TeamList> teamList;

  factory HackathonTeamListModel.fromJson(Map<String, dynamic> json) => HackathonTeamListModel(
    status: json["Status"],
    message: json["Message"],
    teamList: List<TeamList>.from(json["TeamList"].map((x) => TeamList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "TeamList": List<dynamic>.from(teamList.map((x) => x.toJson())),
  };
}

class TeamList {
  TeamList({
    this.problemStatementId,
    this.teamName,
    this.teamSize,
    this.teamId,
  });

  int problemStatementId;
  String teamName;
  int teamSize;
  int teamId;

  factory TeamList.fromJson(Map<String, dynamic> json) => TeamList(
    problemStatementId: json["ProblemStatementId"],
    teamName: json["TeamName"],
    teamSize: json["TeamSize"],
    teamId: json["TeamId"],
  );

  Map<String, dynamic> toJson() => {
    "ProblemStatementId": problemStatementId,
    "TeamName": teamName,
    "TeamSize": teamSize,
    "TeamId": teamId,
  };
}
