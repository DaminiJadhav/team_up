import 'dart:convert';

CollegeModel collegeModelFromJson(String str) => CollegeModel.fromJson(json.decode(str));

String collegeModelToJson(CollegeModel data) => json.encode(data.toJson());

class CollegeModel {
  CollegeModel({
    this.status,
    this.message,
    this.collegeList,
  });

  int status;
  String message;
  List<CollegeList> collegeList;

  factory CollegeModel.fromJson(Map<String, dynamic> json) => CollegeModel(
    status: json["Status"],
    message: json["Message"],
    collegeList: List<CollegeList>.from(json["CollegeList"].map((x) => CollegeList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "CollegeList": List<dynamic>.from(collegeList.map((x) => x.toJson())),
  };
}

class CollegeList {
  CollegeList({
    this.collegeId,
    this.collegeName,
  });

  int collegeId;
  String collegeName;

  factory CollegeList.fromJson(Map<String, dynamic> json) => CollegeList(
    collegeId: json["CollegeId"],
    collegeName: json["CollegeName"],
  );

  Map<String, dynamic> toJson() => {
    "CollegeId": collegeId,
    "CollegeName": collegeName,
  };
}
