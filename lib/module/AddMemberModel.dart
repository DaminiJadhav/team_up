import 'dart:convert';

AddMemberRequestModel addMemberRequestModelFromJson(String str) =>
    AddMemberRequestModel.fromJson(json.decode(str));

String addMemberRequestModelToJson(AddMemberRequestModel data) =>
    json.encode(data.toJson());

class AddMemberRequestModel {
  AddMemberRequestModel({
    this.projectId,
    this.memberId,
    this.memberIsFaculty,
    this.memberIsOrg,
    this.memberIsStudent,
    this.addedById,
    this.addedByFaculty,
    this.addedByOrg,
    this.addedByStudent,
  });

  String projectId;
  String memberId;
  String memberIsFaculty;
  String memberIsOrg;
  String memberIsStudent;
  String addedById;
  String addedByFaculty;
  String addedByOrg;
  String addedByStudent;

  factory AddMemberRequestModel.fromJson(Map<String, dynamic> json) =>
      AddMemberRequestModel(
        projectId: json["ProjectId"],
        memberId: json["MemberId"],
        memberIsFaculty: json["MemberIsFaculty"],
        memberIsOrg: json["MemberIsOrg"],
        memberIsStudent: json["MemberIsStudent"],
        addedById: json["AddedById"],
        addedByFaculty: json["AddedByFaculty"],
        addedByOrg: json["AddedByOrg"],
        addedByStudent: json["AddedByStudent"],
      );

  Map<String, dynamic> toJson() => {
        "ProjectId": projectId,
        "MemberId": memberId,
        "MemberIsFaculty": memberIsFaculty,
        "MemberIsOrg": memberIsOrg,
        "MemberIsStudent": memberIsStudent,
        "AddedById": addedById,
        "AddedByFaculty": addedByFaculty,
        "AddedByOrg": addedByOrg,
        "AddedByStudent": addedByStudent,
      };
}

AddMemberResponseModel addMemberResponseModelFromJson(String str) =>
    AddMemberResponseModel.fromJson(json.decode(str));

String addMemberResponseModelToJson(AddMemberResponseModel data) =>
    json.encode(data.toJson());

class AddMemberResponseModel {
  AddMemberResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory AddMemberResponseModel.fromJson(Map<String, dynamic> json) =>
      AddMemberResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
