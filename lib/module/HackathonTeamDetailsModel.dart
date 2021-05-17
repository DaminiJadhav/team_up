// To parse this JSON data, do
//
//     final hackathonTeamDetailsModel = hackathonTeamDetailsModelFromJson(jsonString);

import 'dart:convert';

HackathonTeamDetailsModel hackathonTeamDetailsModelFromJson(String str) => HackathonTeamDetailsModel.fromJson(json.decode(str));

String hackathonTeamDetailsModelToJson(HackathonTeamDetailsModel data) => json.encode(data.toJson());

class HackathonTeamDetailsModel {
  HackathonTeamDetailsModel({
    this.status,
    this.message,
    this.teamDetails,
  });

  int status;
  String message;
  TeamDetails teamDetails;

  factory HackathonTeamDetailsModel.fromJson(Map<String, dynamic> json) => HackathonTeamDetailsModel(
    status: json["Status"],
    message: json["Message"],
    teamDetails: TeamDetails.fromJson(json["TeamDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "TeamDetails": teamDetails.toJson(),
  };
}

class TeamDetails {
  TeamDetails({
    this.teamName,
    this.statement,
    this.teamMembers,
  });

  String teamName;
  String statement;
  List<TeamMember> teamMembers;

  factory TeamDetails.fromJson(Map<String, dynamic> json) => TeamDetails(
    teamName: json["TeamName"],
    statement: json["Statement"],
    teamMembers: List<TeamMember>.from(json["TeamMembers"].map((x) => TeamMember.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TeamName": teamName,
    "Statement": statement,
    "TeamMembers": List<dynamic>.from(teamMembers.map((x) => x.toJson())),
  };
}

class TeamMember {
  TeamMember({
    this.id,
    this.name,
    this.isStd,
  });

  int id;
  String name;
  bool isStd;

  factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
    id: json["ID"],
    name: json["Name"],
    isStd: json["IsStd"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "IsStd": isStd,
  };
}
