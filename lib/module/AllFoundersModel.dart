
import 'dart:convert';

AllFoundersModel allFoundersModelFromJson(String str) => AllFoundersModel.fromJson(json.decode(str));

String allFoundersModelToJson(AllFoundersModel data) => json.encode(data.toJson());

class AllFoundersModel {
  AllFoundersModel({
    this.status,
    this.message,
    this.founderList,
  });

  int status;
  String message;
  List<FoundersList> founderList;

  factory AllFoundersModel.fromJson(Map<String, dynamic> json) => AllFoundersModel(
    status: json["Status"],
    message: json["Message"],
    founderList: List<FoundersList>.from(json["FounderList"].map((x) => FoundersList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "FounderList": List<dynamic>.from(founderList.map((x) => x.toJson())),
  };
}

class FoundersList {
  FoundersList({
    this.id,
    this.name,
    this.email,
    this.imagePath,
  });

  int id;
  String name;
  String email;
  String imagePath;

  factory FoundersList.fromJson(Map<String, dynamic> json) => FoundersList(
    id: json["ID"],
    name: json["Name"],
    email: json["Email"],
    imagePath: json["ImagePath"] == null ? null : json["ImagePath"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "Email": email,
    "ImagePath": imagePath == null ? null : imagePath,
  };
}
