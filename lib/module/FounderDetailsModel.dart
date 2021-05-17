
import 'dart:convert';

FounderDetailsModel founderDetailsModelFromJson(String str) => FounderDetailsModel.fromJson(json.decode(str));

String founderDetailsModelToJson(FounderDetailsModel data) => json.encode(data.toJson());

class FounderDetailsModel {
  FounderDetailsModel({
    this.status,
    this.message,
    this.founderList,
  });

  int status;
  String message;
  List<FounderList> founderList;

  factory FounderDetailsModel.fromJson(Map<String, dynamic> json) => FounderDetailsModel(
    status: json["Status"],
    message: json["Message"],
    founderList: List<FounderList>.from(json["FounderList"].map((x) => FounderList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "FounderList": List<dynamic>.from(founderList.map((x) => x.toJson())),
  };
}

class FounderList {
  FounderList({
    this.id,
    this.name,
    this.email,
    this.imagePath,
  });

  int id;
  String name;
  String email;
  dynamic imagePath;

  factory FounderList.fromJson(Map<String, dynamic> json) => FounderList(
    id: json["ID"],
    name: json["Name"],
    email: json["Email"],
    imagePath: json["ImagePath"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "Email": email,
    "ImagePath": imagePath,
  };
}
