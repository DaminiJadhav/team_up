import 'dart:convert';

MyProjectListModel myProjectListModelFromJson(String str) =>
    MyProjectListModel.fromJson(json.decode(str));

String myProjectListModelToJson(MyProjectListModel data) =>
    json.encode(data.toJson());

class MyProjectListModel {
  MyProjectListModel({
    this.status,
    this.message,
    this.myProjectList,
  });

  int status;
  String message;
  List<MyProjectList> myProjectList;

  factory MyProjectListModel.fromJson(Map<String, dynamic> json) =>
      MyProjectListModel(
        status: json["Status"],
        message: json["Message"],
        myProjectList: List<MyProjectList>.from(
            json["MyProjectList"].map((x) => MyProjectList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "MyProjectList":
            List<dynamic>.from(myProjectList.map((x) => x.toJson())),
      };
}

class MyProjectList {
  MyProjectList({
    this.projectId,
    this.projectName,
    this.level,
    this.type,
    this.field,
    this.isSubmitted,
    this.submittedOnDate,
    this.isApproved,
  });

  int projectId;
  String projectName;
  String level;
  String type;
  String field;
  bool isSubmitted;
  String submittedOnDate;
  bool isApproved;

  factory MyProjectList.fromJson(Map<String, dynamic> json) => MyProjectList(
        projectId: json["ProjectId"],
        projectName: json["ProjectName"],
        level: json["Level"],
        type: json["Type"],
        field: json["Field"],
        isSubmitted: json["IsSubmitted"],
        submittedOnDate: json["SubmittedOnDate"],
        isApproved: json["IsApproved"],
      );

  Map<String, dynamic> toJson() => {
        "ProjectId": projectId,
        "ProjectName": projectName,
        "Level": level,
        "Type": type,
        "Field": field,
        "IsSubmitted": isSubmitted,
        "SubmittedOnDate": submittedOnDate,
        "IsApproved": isApproved,
      };
}
