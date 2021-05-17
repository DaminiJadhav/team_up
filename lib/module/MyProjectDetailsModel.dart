import 'dart:convert';

MyProjectDetailsModel myProjectDetailsModelFromJson(String str) =>
    MyProjectDetailsModel.fromJson(json.decode(str));

String myProjectDetailsModelToJson(MyProjectDetailsModel data) =>
    json.encode(data.toJson());

class MyProjectDetailsModel {
  MyProjectDetailsModel({
    this.status,
    this.message,
    this.myProjectDetails,
  });

  int status;
  String message;
  MyProjectDetailsList myProjectDetails;

  factory MyProjectDetailsModel.fromJson(Map<String, dynamic> json) =>
      MyProjectDetailsModel(
        status: json["Status"],
        message: json["Message"],
        myProjectDetails:
            MyProjectDetailsList.fromJson(json["MyProjectDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "MyProjectDetails": myProjectDetails.toJson(),
      };
}

class MyProjectDetailsList {
  MyProjectDetailsList({
    this.id,
    this.projectName,
    this.projectHeading,
    this.level,
    this.type,
    this.deadline,
    this.field,
    this.description,
    this.isApproved,
    this.startDate,
    this.endDate,
    this.isReview,
    this.isCreatedByOrg,
    this.createdById,
    this.projectTeamLists,
  });

  int id;
  String projectName;
  String projectHeading;
  String level;
  String type;
  String deadline;
  String field;
  String description;
  bool isApproved;
  String startDate;
  String endDate;
  bool isReview;
  bool isCreatedByOrg;
  int createdById;
  List<ProjectTeamList> projectTeamLists;

  factory MyProjectDetailsList.fromJson(Map<String, dynamic> json) =>
      MyProjectDetailsList(
        id: json["ID"],
        projectName: json["ProjectName"],
        projectHeading: json["ProjectHeading"],
        level: json["Level"],
        type: json["Type"],
        deadline: json["Deadline"],
        field: json["Field"],
        description: json["Description"],
        isApproved: json["IsApproved"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        isReview: json["IsReview"],
        isCreatedByOrg: json["IsCreatedByOrg"],
        createdById: json["CreatedById"],
        projectTeamLists: List<ProjectTeamList>.from(
            json["ProjectTeamLists"].map((x) => ProjectTeamList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "ProjectName": projectName,
        "ProjectHeading": projectHeading,
        "Level": level,
        "Type": type,
        "Deadline": deadline,
        "Field": field,
        "Description": description,
        "IsApproved": isApproved,
        "StartDate": startDate,
        "EndDate": endDate,
        "IsReview": isReview,
        "IsCreatedByOrg": isCreatedByOrg,
        "CreatedById": createdById,
        "ProjectTeamLists":
            List<dynamic>.from(projectTeamLists.map((x) => x.toJson())),
      };
}

class ProjectTeamList {
  ProjectTeamList({
    this.id,
    this.name,
    this.email,
    this.userName,
    this.imagePath,
  });

  int id;
  String name;
  String email;
  String userName;
  dynamic imagePath;

  factory ProjectTeamList.fromJson(Map<String, dynamic> json) =>
      ProjectTeamList(
        id: json["ID"],
        name: json["Name"],
        email: json["Email"],
        userName: json["UserName"] == null ? null : json["UserName"],
        imagePath: json["ImagePath"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "Email": email,
        "UserName": userName == null ? null : userName,
        "ImagePath": imagePath,
      };
}
