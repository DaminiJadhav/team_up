import 'dart:convert';

UpdateFounderDetailsRequestModel updateFounderDetailsRequestModelFromJson(
        String str) =>
    UpdateFounderDetailsRequestModel.fromJson(json.decode(str));

String updateFounderDetailsRequestModelToJson(
        UpdateFounderDetailsRequestModel data) =>
    json.encode(data.toJson());

class UpdateFounderDetailsRequestModel {
  UpdateFounderDetailsRequestModel({
    this.id,
    this.name,
    this.email,
    this.imagePath,
    this.IsImageChange,
  });

  String id;
  String name;
  String email;
  String imagePath;
  bool IsImageChange;

  factory UpdateFounderDetailsRequestModel.fromJson(
          Map<String, dynamic> json) =>
      UpdateFounderDetailsRequestModel(
        id: json["ID"],
        name: json["Name"],
        email: json["Email"],
        imagePath: json["ImagePath"],
        IsImageChange: json["IsImageChange"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "Email": email,
        "ImagePath": imagePath,
        "IsImageChange": IsImageChange,
      };
}

UpdateFounderDetailsResponseModel updateFounderDetailsResponseModelFromJson(
        String str) =>
    UpdateFounderDetailsResponseModel.fromJson(json.decode(str));

String updateFounderDetailsResponseModelToJson(
        UpdateFounderDetailsResponseModel data) =>
    json.encode(data.toJson());

class UpdateFounderDetailsResponseModel {
  UpdateFounderDetailsResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory UpdateFounderDetailsResponseModel.fromJson(
          Map<String, dynamic> json) =>
      UpdateFounderDetailsResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
