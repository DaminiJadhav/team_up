import 'dart:convert';

AllExperienceModel allExperienceModelFromJson(String str) => AllExperienceModel.fromJson(json.decode(str));

String allExperienceModelToJson(AllExperienceModel data) => json.encode(data.toJson());

class AllExperienceModel {
  AllExperienceModel({
    this.status,
    this.message,
    this.experience,
  });

  int status;
  String message;
  List<Experience> experience;

  factory AllExperienceModel.fromJson(Map<String, dynamic> json) => AllExperienceModel(
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
  });

  int id;
  String companyName;
  String address;
  String yourRole;
  String description;
  String startDate;
  String endDate;
  bool isCurrent;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    id: json["ID"],
    companyName: json["CompanyName"],
    address: json["Address"],
    yourRole: json["YourRole"],
    description: json["Description"],
    startDate: json["StartDate"],
    endDate: json["EndDate"],
    isCurrent: json["IsCurrent"],
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
  };
}
