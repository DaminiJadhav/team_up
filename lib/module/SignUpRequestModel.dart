import 'dart:convert';

SignUpFirstRequestModel signUpFirstRequestModelFromJson(String str) => SignUpFirstRequestModel.fromJson(json.decode(str));

String signUpFirstRequestModelToJson(SignUpFirstRequestModel data) => json.encode(data.toJson());

class SignUpFirstRequestModel {
  SignUpFirstRequestModel({
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.collegeId,
    this.aboutMyself,
    this.imagePath,
  });

  String firstname;
  String lastname;
  String email;
  String phone;
  String collegeId;
  String aboutMyself;
  String imagePath;

  factory SignUpFirstRequestModel.fromJson(Map<String, dynamic> json) => SignUpFirstRequestModel(
    firstname: json["Firstname"],
    lastname: json["Lastname"],
    email: json["Email"],
    phone: json["Phone"],
    collegeId: json["CollegeId"],
    aboutMyself: json["About_myself"],
    imagePath: json["ImagePath"],
  );

  Map<String, dynamic> toJson() => {
    "Firstname": firstname,
    "Lastname": lastname,
    "Email": email,
    "Phone": phone,
    "CollegeId": collegeId,
    "About_myself": aboutMyself,
    "ImagePath": imagePath,
  };
}


SignUpFirstResponseModel signUpFirstResponseModelFromJson(String str) => SignUpFirstResponseModel.fromJson(json.decode(str));

String signUpFirstResponseModelToJson(SignUpFirstResponseModel data) => json.encode(data.toJson());

class SignUpFirstResponseModel {
  SignUpFirstResponseModel({
    this.status,
    this.message,
    this.id,
    this.smscode,
    this.emailcode,
  });

  int status;
  String message;
  int id;
  String smscode;
  String emailcode;

  factory SignUpFirstResponseModel.fromJson(Map<String, dynamic> json) => SignUpFirstResponseModel(
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