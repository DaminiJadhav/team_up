import 'dart:convert';

GetEducationDetailModel getEducationDetailModelFromJson(String str) => GetEducationDetailModel.fromJson(json.decode(str));

String getEducationDetailModelToJson(GetEducationDetailModel data) => json.encode(data.toJson());

class GetEducationDetailModel {
  GetEducationDetailModel({
    this.status,
    this.message,
    this.preEducation,
  });

  int status;
  String message;
  List<PreEducation> preEducation;

  factory GetEducationDetailModel.fromJson(Map<String, dynamic> json) => GetEducationDetailModel(
    status: json["Status"],
    message: json["Message"],
    preEducation: List<PreEducation>.from(json["Pre_Education"].map((x) => PreEducation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Pre_Education": List<dynamic>.from(preEducation.map((x) => x.toJson())),
  };
}

class PreEducation {
  PreEducation({
    this.id,
    this.courseName,
    this.intituteName,
    this.grade,
    this.startDate,
    this.endDate,
    this.createdOn,
  });

  int id;
  String courseName;
  String intituteName;
  String grade;
  String startDate;
  String endDate;
  DateTime createdOn;

  factory PreEducation.fromJson(Map<String, dynamic> json) => PreEducation(
    id: json["ID"],
    courseName: json["CourseName"],
    intituteName: json["IntituteName"],
    grade: json["Grade"],
    startDate: json["StartDate"],
    endDate: json["EndDate"],
    createdOn: DateTime.parse(json["CreatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CourseName": courseName,
    "IntituteName": intituteName,
    "Grade": grade,
    "StartDate": startDate,
    "EndDate": endDate,
    "CreatedOn": createdOn.toIso8601String(),
  };
}
