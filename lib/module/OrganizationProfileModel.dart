import 'dart:convert';

OrganizationProfileModel organizationProfileModelFromJson(String str) => OrganizationProfileModel.fromJson(json.decode(str));

String organizationProfileModelToJson(OrganizationProfileModel data) => json.encode(data.toJson());

class OrganizationProfileModel {
  OrganizationProfileModel({
    this.status,
    this.message,
    this.userProfile,
    this.project,
    this.founders,
  });

  int status;
  String message;
  List<UserProfile> userProfile;
  List<Project> project;
  List<Founder> founders;

  factory OrganizationProfileModel.fromJson(Map<String, dynamic> json) => OrganizationProfileModel(
    status: json["Status"],
    message: json["Message"],
    userProfile: List<UserProfile>.from(json["UserProfile"].map((x) => UserProfile.fromJson(x))),
    project: List<Project>.from(json["Project"].map((x) => Project.fromJson(x))),
    founders: List<Founder>.from(json["Founders"].map((x) => Founder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "UserProfile": List<dynamic>.from(userProfile.map((x) => x.toJson())),
    "Project": List<dynamic>.from(project.map((x) => x.toJson())),
    "Founders": List<dynamic>.from(founders.map((x) => x.toJson())),
  };
}

class Founder {
  Founder({
    this.id,
    this.name,
    this.email,
    this.imagePath,
  });

  int id;
  String name;
  String email;
  String imagePath;

  factory Founder.fromJson(Map<String, dynamic> json) => Founder(
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

class Project {
  Project({
    this.projectname,
    this.submittedOn,
    this.description,
  });

  String projectname;
  DateTime submittedOn;
  String description;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    projectname: json["Projectname"],
    submittedOn: DateTime.parse(json["SubmittedOn"]),
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "Projectname": projectname,
    "SubmittedOn": submittedOn.toIso8601String(),
    "Description": description,
  };
}

class UserProfile {
  UserProfile({
    this.id,
    this.imagePath,
    this.orgName,
    this.username,
    this.email,
    this.name,
    this.country,
    this.state,
    this.city,
    this.website,
    this.address,
    this.ourWork,
  });

  int id;
  String imagePath;
  String orgName;
  String username;
  String email;
  String name;
  String country;
  String state;
  String city;
  String website;
  String address;
  String ourWork;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["ID"],
    imagePath: json["ImagePath"],
    orgName: json["OrgName"],
    username: json["Username"],
    email: json["Email"],
    name: json["Name"],
    country: json["Country"],
    state: json["State"],
    city: json["City"],
    website: json["Website"],
    address: json["Address"],
    ourWork: json["OurWork"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "ImagePath": imagePath,
    "OrgName": orgName,
    "Username": username,
    "Email": email,
    "Name": name,
    "Country": country,
    "State": state,
    "City": city,
    "Website": website,
    "Address": address,
    "OurWork": ourWork,
  };
}
