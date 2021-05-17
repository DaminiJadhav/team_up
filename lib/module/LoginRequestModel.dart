import 'dart:convert';

class LoginRequestModel {
  String isStudent;
  String isFaculty;
  String isOrganzation;
  String userName;
  String email;
  String contactNp;
  String password;
  String smsCode;
  String emailCode;
  String fcm;


  LoginRequestModel(
      {this.isStudent,
      this.isFaculty,
      this.isOrganzation,
      this.userName,
      this.email,
      this.contactNp,
      this.password,
      this.smsCode,
      this.emailCode,
      this.fcm});

  toJson() {
    Map<String, dynamic> map = {
      'IsStudent': isStudent,
      'Isfaculty': isFaculty,
      'Isorg': isOrganzation,
      'username': userName,
      'email': email,
      'contactno': contactNp,
      'password': password,
      'SMSCode': smsCode,
      'EmailCode': emailCode,
      'fcmId': fcm
    };
    return jsonEncode(map);
  }
}

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.message,
    this.student,
  });

  int status;
  String message;
  List<Student> student;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["Status"],
    message: json["Message"],
    student: List<Student>.from(json["Student"].map((x) => Student.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Student": List<dynamic>.from(student.map((x) => x.toJson())),
  };
}

class Student {
  Student({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.profilePic,
    this.city,
    this.state,
    this.country,
    this.address,
  });

  int id;
  String firstname;
  String lastname;
  String email;
  String phone;
  dynamic profilePic;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic address;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["ID"],
    firstname: json["Firstname"],
    lastname: json["Lastname"],
    email: json["Email"],
    phone: json["Phone"],
    profilePic: json["Profile_Pic"],
    city: json["City"],
    state: json["State"],
    country: json["Country"],
    address: json["Address"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Firstname": firstname,
    "Lastname": lastname,
    "Email": email,
    "Phone": phone,
    "Profile_Pic": profilePic,
    "City": city,
    "State": state,
    "Country": country,
    "Address": address,
  };
}

