import 'dart:convert';
// To parse this JSON data, do
//
//     final orgSignUpFirst = orgSignUpFirstFromJson(jsonString);


OrgSignUpFirst orgSignUpFirstFromJson(String str) => OrgSignUpFirst.fromJson(json.decode(str));

String orgSignUpFirstToJson(OrgSignUpFirst data) => json.encode(data.toJson());

class OrgSignUpFirst {
  OrgSignUpFirst({
    this.id,
    this.orgName,
    this.aboutUs,
    this.orgTypeId,
    this.email,
    this.phone,
    this.imagePath,
    this.website,
    this.specialties,
    this.establishmentDate,
    this.termConditions,
  });

  String id;
  String orgName;
  String aboutUs;
  String orgTypeId;
  String email;
  String phone;
  String imagePath;
  String website;
  String specialties;
  String establishmentDate;
  bool termConditions;

  factory OrgSignUpFirst.fromJson(Map<String, dynamic> json) => OrgSignUpFirst(
    id: json["ID"],
    orgName: json["OrgName"],
    aboutUs: json["About_Us"],
    orgTypeId: json["OrgTypeId"],
    email: json["Email"],
    phone: json["Phone"],
    imagePath: json["ImagePath"],
    website: json["Website"],
    specialties: json["Specialties"],
    establishmentDate: json["Establishment_date"],
    termConditions: json["TermConditions"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "OrgName": orgName,
    "About_Us": aboutUs,
    "OrgTypeId": orgTypeId,
    "Email": email,
    "Phone": phone,
    "Website": website,
    "Specialties": specialties,
    "Establishment_date": establishmentDate,
    "TermConditions": termConditions,
    "ImagePath": imagePath,
  };
}

OrgSignUpFirstResponseModel orgSignUpFirstResponseModelFromJson(String str) => OrgSignUpFirstResponseModel.fromJson(json.decode(str));

String orgSignUpFirstResponseModelToJson(OrgSignUpFirstResponseModel data) => json.encode(data.toJson());

class OrgSignUpFirstResponseModel {
  OrgSignUpFirstResponseModel({
    this.status,
    this.message,
    this.id,
    this.smscode,
    this.emailcode,
  });

  int status;
  String message;
  int id;
  dynamic smscode;
  String emailcode;

  factory OrgSignUpFirstResponseModel.fromJson(Map<String, dynamic> json) => OrgSignUpFirstResponseModel(
    status: json["Status"],
    message: json["Message"],
    id: json["Id"],
    smscode: json["Smscode"],
    emailcode: json["Emailcode"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Id": id,
    "Smscode": smscode,
    "Emailcode": emailcode,
  };
}

