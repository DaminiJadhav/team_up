import 'dart:convert';

UpdatePersonDetailsModel updatePersonDetailsModelFromJson(String str) => UpdatePersonDetailsModel.fromJson(json.decode(str));

String updatePersonDetailsModelToJson(UpdatePersonDetailsModel data) => json.encode(data.toJson());

class UpdatePersonDetailsModel {
  UpdatePersonDetailsModel({
    this.id,
    this.firstname,
    this.lastname,
    this.city,
    this.state,
    this.country,
    this.address,
    this.imagePath,
    this.IsImageChange,
  });

  String id;
  String firstname;
  String lastname;
  String city;
  String state;
  String country;
  String address;
  String imagePath;
  bool IsImageChange;

  factory UpdatePersonDetailsModel.fromJson(Map<String, dynamic> json) => UpdatePersonDetailsModel(
    id: json["ID"],
    firstname: json["Firstname"],
    lastname: json["Lastname"],
    city: json["City"],
    state: json["State"],
    country: json["Country"],
    address: json["Address"],
    imagePath: json["ImagePath"],
      IsImageChange:json["IsImageChange"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Firstname": firstname,
    "Lastname": lastname,
    "City": city,
    "State": state,
    "Country": country,
    "Address": address,
    "ImagePath": imagePath,
    "IsImageChange":IsImageChange,
  };
}
UpdatePersonDetailsResponseModel updatePersonDetailsResponseModelFromJson(String str) => UpdatePersonDetailsResponseModel.fromJson(json.decode(str));

String updatePersonDetailsResponseModelToJson(UpdatePersonDetailsResponseModel data) => json.encode(data.toJson());

class UpdatePersonDetailsResponseModel {
  UpdatePersonDetailsResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory UpdatePersonDetailsResponseModel.fromJson(Map<String, dynamic> json) => UpdatePersonDetailsResponseModel(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}
