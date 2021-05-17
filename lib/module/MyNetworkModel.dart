import 'dart:convert';

MyNetworkModel myNetworkModelFromJson(String str) =>
    MyNetworkModel.fromJson(json.decode(str));

String myNetworkModelToJson(MyNetworkModel data) => json.encode(data.toJson());

class MyNetworkModel {
  MyNetworkModel({
    this.status,
    this.message,
    this.members,
  });

  int status;
  String message;
  List<Member> members;

  factory MyNetworkModel.fromJson(Map<String, dynamic> json) => MyNetworkModel(
        status: json["Status"],
        message: json["Message"],
        members:
            List<Member>.from(json["Members"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Members": List<dynamic>.from(members.map((x) => x.toJson())),
      };
}

class Member {
  Member({
    this.Id,
    this.name,
    this.username,
    this.email,
    this.IsStudent,
    this.imageUrl,
  });

  int Id;
  String name;
  String username;
  String email;
  bool IsStudent;
  String imageUrl;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        Id: json["Id"],
        name: json["Name"],
        username: json["Username"],
        email: json["Email"],
        IsStudent: json["IsStudent"],
      imageUrl : json["ImagePath"],

      );

  Map<String, dynamic> toJson() => {
        "Id": Id,
        "Name": name,
        "Username": username,
        "Email": email,
        "IsStudent": IsStudent,
        "ImagePath" : imageUrl,
      };
}
