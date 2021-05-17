import 'dart:convert';

AllMemberListModel memberListModelFromJson(String str) => AllMemberListModel.fromJson(json.decode(str));

String memberListModelToJson(AllMemberListModel data) => json.encode(data.toJson());

class AllMemberListModel {
  AllMemberListModel({
    this.status,
    this.message,
    this.member,
  });

  int status;
  String message;
  List<Member> member;

  factory AllMemberListModel.fromJson(Map<String, dynamic> json) => AllMemberListModel(
    status: json["Status"],
    message: json["Message"],
    member: List<Member>.from(json["Member"].map((x) => Member.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Member": List<dynamic>.from(member.map((x) => x.toJson())),
  };
}

class Member {
  Member({
    this.id,
    this.name,
    this.isStudent,
  });

  int id;
  String name;
  bool isStudent;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["ID"],
    name: json["Name"],
    isStudent: json["IsStudent"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "IsStudent": isStudent,
  };
}