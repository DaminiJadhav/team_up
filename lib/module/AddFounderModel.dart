import 'dart:convert';

AddFounderRequestModel addFounderRequestModelFromJson(String str) =>
    AddFounderRequestModel.fromJson(json.decode(str));

String addFounderRequestModelToJson(AddFounderRequestModel data) =>
    json.encode(data.toJson());

class AddFounderRequestModel {
  AddFounderRequestModel({
    this.orgId,
    this.name,
    this.email,
    this.imagePath,
  });

  String orgId;
  String name;
  String email;
  String imagePath;

  factory AddFounderRequestModel.fromJson(Map<String, dynamic> json) =>
      AddFounderRequestModel(
        orgId: json["OrgId"],
        name: json["Name"],
        email: json["Email"],
        imagePath: json["ImagePath"],
      );

  Map<String, dynamic> toJson() => {
        "OrgId": orgId,
        "Name": name,
        "Email": email,
        "ImagePath": imagePath,
      };
}

AddFounderResponseModel addFounderResponseModelFromJson(String str) =>
    AddFounderResponseModel.fromJson(json.decode(str));

String addFounderResponseModelToJson(AddFounderResponseModel data) =>
    json.encode(data.toJson());

class AddFounderResponseModel {
  AddFounderResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory AddFounderResponseModel.fromJson(Map<String, dynamic> json) =>
      AddFounderResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
