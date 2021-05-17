import 'dart:convert';

GetPersonDetailsModel getPersonDetailsModelFromJson(String str) => GetPersonDetailsModel.fromJson(json.decode(str));

String getPersonDetailsModelToJson(GetPersonDetailsModel data) => json.encode(data.toJson());

class GetPersonDetailsModel {
  GetPersonDetailsModel({
    this.status,
    this.message,
    this.students,
  });

  int status;
  String message;
  List<Student> students;

  factory GetPersonDetailsModel.fromJson(Map<String, dynamic> json) => GetPersonDetailsModel(
    status: json["Status"],
    message: json["Message"],
    students: List<Student>.from(json["Students"].map((x) => Student.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Students": List<dynamic>.from(students.map((x) => x.toJson())),
  };
}

class Student {
  Student({
    this.id,
    this.firstname,
    this.lastname,
    this.countryId,
    this.country,
    this.stateId,
    this.state,
    this.cityId,
    this.city,
    this.address,
    this.imagePath,
  });

  int id;
  String firstname;
  String lastname;
  int countryId;
  String country;
  int stateId;
  String state;
  int cityId;
  String city;
  String address;
  String imagePath;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["ID"],
    firstname: json["Firstname"],
    lastname: json["Lastname"],
    countryId: json["CountryId"],
    country: json["Country"],
    stateId: json["StateId"],
    state: json["State"],
    cityId: json["CityId"],
    city: json["City"],
    address: json["Address"],
    imagePath: json["ImagePath"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Firstname": firstname,
    "Lastname": lastname,
    "CountryId": countryId,
    "Country": country,
    "StateId": stateId,
    "State": state,
    "CityId": cityId,
    "City": city,
    "Address": address,
    "ImagePath": imagePath,
  };
}
