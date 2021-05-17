// To parse this JSON data, do
//
//     final getProjectDetailsModel = getProjectDetailsModelFromJson(jsonString);

import 'dart:convert';

GetProjectDetailsModel getProjectDetailsModelFromJson(String str) =>
    GetProjectDetailsModel.fromJson(json.decode(str));

String getProjectDetailsModelToJson(GetProjectDetailsModel data) =>
    json.encode(data.toJson());

class GetProjectDetailsModel {
  GetProjectDetailsModel({
    this.status,
    this.message,
    this.project,
    this.members,
  });

  int status;
  String message;
  List<Project> project;
  List<Member> members;

  factory GetProjectDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetProjectDetailsModel(
        status: json["Status"],
        message: json["Message"],
        project:
            List<Project>.from(json["Project"].map((x) => Project.fromJson(x))),
        members:
            List<Member>.from(json["Members"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Project": List<dynamic>.from(project.map((x) => x.toJson())),
        "Members": List<dynamic>.from(members.map((x) => x.toJson())),
      };
}

class Member {
  Member({
    this.name,
    this.username,
    this.email,
    this.ImagePath,
    this.IsStudent,
    this.Id,
  });

  int Id;
  String name;
  String username;
  String email;
  String ImagePath;
  bool IsStudent;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        name: json["Name"],
        username: json["Username"],
        email: json["Email"],
        ImagePath: json["ImagePath"],
        IsStudent: json["IsStudent"],
        Id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Username": username,
        "Email": email,
        "IsStudent": IsStudent,
        "ImagePath": ImagePath,
        "Id": Id,
      };
}

class Project {
  Project({
    this.id,
    this.projectname,
    this.projectheading,
    this.levels,
    this.endDate,
    this.startDate,
    this.type,
    this.teamMembers,
    this.field,
    this.description,
    this.createdId,
    this.isStd,
  });

  int id;
  String projectname;
  String projectheading;
  String levels;
  String startDate;
  String endDate;
  String type;
  int teamMembers;
  String field;
  String description;
  int createdId;
  bool isStd;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["ID"],
        projectname: json["Projectname"],
        projectheading: json["Projectheading"],
        levels: json["Levels"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        type: json["Type"],
        teamMembers: json["TeamMembers"],
        field: json["Field"],
        description: json["Description"],
        createdId: json["CreatedId"],
        isStd: json["IsStd"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Projectname": projectname,
        "Projectheading": projectheading,
        "Levels": levels,
        "StartDate": startDate,
        "EndDate": endDate,
        "Type": type,
        "TeamMembers": teamMembers,
        "Field": field,
        "Description": description,
        "CreatedId": createdId,
        "IsStd": isStd,
      };
}
