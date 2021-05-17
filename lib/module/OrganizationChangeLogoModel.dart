import 'dart:convert';

OrganizationChangeLogoRequestModel organizationChangeLogoRequestModelFromJson(
        String str) =>
    OrganizationChangeLogoRequestModel.fromJson(json.decode(str));

String organizationChangeLogoRequestModelToJson(
        OrganizationChangeLogoRequestModel data) =>
    json.encode(data.toJson());

class OrganizationChangeLogoRequestModel {
  OrganizationChangeLogoRequestModel({
    this.id,
    this.imagePath,
  });

  String id;
  String imagePath;

  factory OrganizationChangeLogoRequestModel.fromJson(
          Map<String, dynamic> json) =>
      OrganizationChangeLogoRequestModel(
        id: json["ID"],
        imagePath: json["ImagePath"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "ImagePath": imagePath,
      };
}

OrganizationChangeLogoResponseModel organizationChangeLogoResponseModelFromJson(
        String str) =>
    OrganizationChangeLogoResponseModel.fromJson(json.decode(str));

String organizationChangeLogoResponseModelToJson(
        OrganizationChangeLogoResponseModel data) =>
    json.encode(data.toJson());

class OrganizationChangeLogoResponseModel {
  OrganizationChangeLogoResponseModel({
    this.status,
    this.message,
    this.ImagePath,
  });

  int status;
  String message;
  String ImagePath;

  factory OrganizationChangeLogoResponseModel.fromJson(
          Map<String, dynamic> json) =>
      OrganizationChangeLogoResponseModel(
        status: json["Status"],
        message: json["Message"],
          ImagePath : json["ImagePath"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
    "ImagePath":ImagePath,
      };
}
