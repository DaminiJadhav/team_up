import 'dart:convert';

CreateTeamRequestModel createTeamRequestModelFromJson(String str) => CreateTeamRequestModel.fromJson(json.decode(str));

String createTeamRequestModelToJson(CreateTeamRequestModel data) => json.encode(data.toJson());

class CreateTeamRequestModel {
  CreateTeamRequestModel({
    this.hackathonId,
    this.problemStatementId,
    this.teamName,
    this.statement,
    this.teamSize,
    this.createdByIsStd,
    this.createdByUserId,
  });

  String hackathonId;
  String problemStatementId;
  String teamName;
  String statement;
  String teamSize;
  bool createdByIsStd;
  String createdByUserId;

  factory CreateTeamRequestModel.fromJson(Map<String, dynamic> json) => CreateTeamRequestModel(
    hackathonId: json["HackathonId"],
    problemStatementId: json["ProblemStatementId"],
    teamName: json["TeamName"],
    statement: json["Statement"],
    teamSize: json["TeamSize"],
    createdByIsStd: json["CreatedByIsStd"],
    createdByUserId: json["CreatedByUserId"],
  );

  Map<String, dynamic> toJson() => {
    "HackathonId": hackathonId,
    "ProblemStatementId": problemStatementId,
    "TeamName": teamName,
    "Statement": statement,
    "TeamSize": teamSize,
    "CreatedByIsStd": createdByIsStd,
    "CreatedByUserId": createdByUserId,
  };
}
CreateTeamResponseModel createTeamResponseModelFromJson(String str) => CreateTeamResponseModel.fromJson(json.decode(str));

String createTeamResponseModelToJson(CreateTeamResponseModel data) => json.encode(data.toJson());

class CreateTeamResponseModel {
  CreateTeamResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory CreateTeamResponseModel.fromJson(Map<String, dynamic> json) => CreateTeamResponseModel(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}
