import 'dart:convert';

class SAddProjectRequestModel {
  String StdId;
  String Projectname;
  String Projectheading;
  String Type;
  String Levels;
  String Field;
  String Description;
  String ProjectTags;
  String TeamMembers;
  String EndDate;
  String TypeOfpeople;

  SAddProjectRequestModel(
      {this.StdId,
      this.Projectname,
      this.Projectheading,
      this.Type,
      this.Levels,
      this.Field,
      this.Description,
      this.ProjectTags,
      this.TeamMembers,
      this.EndDate,
      this.TypeOfpeople});

  toJson() {
    Map<String, dynamic> map = {
      "StdId": StdId,
      "Projectname": Projectname,
      "Projectheading": Projectheading,
      "Type": Type,
      "Levels": Levels,
      "Field": Field,
      "Description": Description,
      "ProjectTags": ProjectTags,
      "TeamMembers": TeamMembers,
      "EndDate": EndDate,
      "TypeOfpeople": TypeOfpeople
    };
    return jsonEncode(map);
  }
}

SAddProjectResponseModel sAddProjectResponseModelFromJson(String str) =>
    SAddProjectResponseModel.fromJson(json.decode(str));

String sAddProjectResponseModelToJson(SAddProjectResponseModel data) =>
    json.encode(data.toJson());

class SAddProjectResponseModel {
  SAddProjectResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory SAddProjectResponseModel.fromJson(Map<String, dynamic> json) =>
      SAddProjectResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
