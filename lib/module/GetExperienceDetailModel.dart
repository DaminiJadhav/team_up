import 'dart:convert';

GetExperienceDetailModel getExperienceDetailModelFromJson(String str) => GetExperienceDetailModel.fromJson(json.decode(str));

String getExperienceDetailModelToJson(GetExperienceDetailModel data) => json.encode(data.toJson());

class GetExperienceDetailModel {
  GetExperienceDetailModel({
    this.status,
    this.message,
    this.experience,
  });

  int status;
  String message;
  List<Experience> experience;

  factory GetExperienceDetailModel.fromJson(Map<String, dynamic> json) => GetExperienceDetailModel(
    status: json["Status"],
    message: json["Message"],
    experience: List<Experience>.from(json["Experience"].map((x) => Experience.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Experience": List<dynamic>.from(experience.map((x) => x.toJson())),
  };
}

class Experience {
  Experience({
    this.id,
    this.companyName,
    this.address,
    this.yourRole,
    this.description,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.createdOn,
  });

  int id;
  String companyName;
  String address;
  String yourRole;
  String description;
  String startDate;
  String endDate;
  bool isCurrent;
  DateTime createdOn;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    id: json["ID"],
    companyName: json["CompanyName"],
    address: json["Address"],
    yourRole: json["YourRole"],
    description: json["Description"],
    startDate: json["StartDate"],
    endDate: json["EndDate"],
    isCurrent: json["IsCurrent"],
    createdOn: DateTime.parse(json["CreatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CompanyName": companyName,
    "Address": address,
    "YourRole": yourRole,
    "Description": description,
    "StartDate": startDate,
    "EndDate": endDate,
    "IsCurrent": isCurrent,
    "CreatedOn": createdOn.toIso8601String(),
  };
}
