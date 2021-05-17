import 'dart:convert';

PersonProfileDetailsModel personProfileDetailsModelFromJson(String str) =>
    PersonProfileDetailsModel.fromJson(json.decode(str));

String personProfileDetailsModelToJson(PersonProfileDetailsModel data) =>
    json.encode(data.toJson());

class PersonProfileDetailsModel {
  PersonProfileDetailsModel({
    this.status,
    this.message,
    this.userProfile,
    this.project,
    this.certificate,
    this.education,
    this.experience,
  });

  int status;
  String message;
  List<UserProfile> userProfile;
  List<Project> project;
  List<Certificate> certificate;
  List<Education> education;
  List<Experience> experience;

  factory PersonProfileDetailsModel.fromJson(Map<String, dynamic> json) =>
      PersonProfileDetailsModel(
        status: json["Status"],
        message: json["Message"],
        userProfile: List<UserProfile>.from(
            json["UserProfile"].map((x) => UserProfile.fromJson(x))),
        project:
            List<Project>.from(json["Project"].map((x) => Project.fromJson(x))),
        certificate: List<Certificate>.from(
            json["Certificate"].map((x) => Certificate.fromJson(x))),
        education: List<Education>.from(
            json["Education"].map((x) => Education.fromJson(x))),
        experience: List<Experience>.from(
            json["Experience"].map((x) => Experience.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "UserProfile": List<dynamic>.from(userProfile.map((x) => x.toJson())),
        "Project": List<dynamic>.from(project.map((x) => x.toJson())),
        "Certificate": List<dynamic>.from(certificate.map((x) => x.toJson())),
        "Education": List<dynamic>.from(education.map((x) => x.toJson())),
        "Experience": List<dynamic>.from(experience.map((x) => x.toJson())),
      };
}

class Certificate {
  Certificate({
    this.name,
    this.issuedAuthorityName,
    this.issuedDate,
    this.createdOn,
  });

  String name;
  String issuedAuthorityName;
  String issuedDate;
  DateTime createdOn;

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        name: json["Name"],
        issuedAuthorityName: json["IssuedAuthorityName"],
        issuedDate: json["IssuedDate"],
        createdOn: DateTime.parse(json["CreatedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "IssuedAuthorityName": issuedAuthorityName,
        "IssuedDate": issuedDate,
        "CreatedOn": createdOn.toIso8601String(),
      };
}

class Education {
  Education({
    this.intituteName,
    this.courseName,
    this.startDate,
    this.endDate,
    this.createdOn,
    this.Grade,
  });

  String intituteName;
  String courseName;
  String startDate;
  String endDate;
  String Grade;
  DateTime createdOn;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        intituteName: json["IntituteName"],
        courseName: json["CourseName"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        Grade: json["Grade"],
        createdOn: DateTime.parse(json["CreatedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "IntituteName": intituteName,
        "CourseName": courseName,
        "StartDate": startDate,
        "EndDate": endDate,
        "Grade": Grade,
        "CreatedOn": createdOn.toIso8601String(),
      };
}

class Experience {
  Experience(
      {this.companyName,
      this.yourRole,
      this.startDate,
      this.endDate,
      this.createdOn,
      this.Address,
      this.Description});

  String companyName;
  String yourRole;
  String startDate;
  String endDate;
  String Description;
  String Address;
  DateTime createdOn;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        companyName: json["CompanyName"],
        yourRole: json["YourRole"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        Description: json["Description"],
        Address: json["Address"],
        createdOn: DateTime.parse(json["CreatedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "CompanyName": companyName,
        "YourRole": yourRole,
        "StartDate": startDate,
        "EndDate": endDate,
        "Description": Description,
        "Address": Address,
        "CreatedOn": createdOn.toIso8601String(),
      };
}

class Project {
  Project({
    this.projectname,
    this.description,
    this.submittedOn,
  });

  String projectname;
  String description;
  dynamic submittedOn;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        projectname: json["Projectname"],
        description: json["Description"],
        submittedOn: json["SubmittedOn"],
      );

  Map<String, dynamic> toJson() => {
        "Projectname": projectname,
        "Description": description,
        "SubmittedOn": submittedOn,
      };
}

class UserProfile {
  UserProfile({
    this.name,
    this.username,
    this.email,
    this.city,
    this.aboutMe,
    this.imagePath,
  });

  String name;
  String username;
  String email;
  String city;
  String aboutMe;
  String imagePath;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        name: json["Name"],
        username: json["Username"],
        email: json["Email"],
        city: json["City"],
        aboutMe: json["AboutMe"],
        imagePath: json["ImagePath"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Username": username,
        "Email": email,
        "City": city,
        "AboutMe": aboutMe,
        "ImagePath": imagePath,
      };
}
