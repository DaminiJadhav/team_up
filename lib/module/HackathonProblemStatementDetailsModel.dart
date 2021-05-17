import 'dart:convert';

HackathonProblemStatementDetailsModel
    hackathonProblemStatementDetailsModelFromJson(String str) =>
        HackathonProblemStatementDetailsModel.fromJson(json.decode(str));

String hackathonProblemStatementDetailsModelToJson(
        HackathonProblemStatementDetailsModel data) =>
    json.encode(data.toJson());

class HackathonProblemStatementDetailsModel {
  HackathonProblemStatementDetailsModel({
    this.status,
    this.message,
    this.problemStatementDetails,
  });

  int status;
  String message;
  ProblemStatementDetails problemStatementDetails;

  factory HackathonProblemStatementDetailsModel.fromJson(
          Map<String, dynamic> json) =>
      HackathonProblemStatementDetailsModel(
        status: json["Status"],
        message: json["Message"],
        problemStatementDetails:
            ProblemStatementDetails.fromJson(json["ProblemStatementDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "ProblemStatementDetails": problemStatementDetails.toJson(),
      };
}

class ProblemStatementDetails {
  ProblemStatementDetails({
    this.problemStatementHeading,
    this.description,
    this.teamList,
  });

  String problemStatementHeading;
  String description;
  List<TeamList> teamList;

  factory ProblemStatementDetails.fromJson(Map<String, dynamic> json) =>
      ProblemStatementDetails(
        problemStatementHeading: json["ProblemStatementHeading"],
        description: json["Description"],
        teamList: List<TeamList>.from(
            json["TeamList"].map((x) => TeamList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ProblemStatementHeading": problemStatementHeading,
        "Description": description,
        "TeamList": List<dynamic>.from(teamList.map((x) => x.toJson())),
      };
}

class TeamList {
  TeamList({
    this.teamName,
    this.teamSize,
    this.teamId,
  });

  String teamName;
  int teamSize;
  int teamId;

  factory TeamList.fromJson(Map<String, dynamic> json) => TeamList(
        teamName: json["TeamName"],
        teamSize: json["TeamSize"],
        teamId: json["TeamId"],
      );

  Map<String, dynamic> toJson() => {
        "TeamName": teamName,
        "TeamSize": teamSize,
        "TeamId": teamId,
      };
}
