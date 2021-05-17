import 'dart:convert';

UpdateOurWorkRequestModel updateOurWorkRequestModelFromJson(String str) => UpdateOurWorkRequestModel.fromJson(json.decode(str));

String updateOurWorkRequestModelToJson(UpdateOurWorkRequestModel data) => json.encode(data.toJson());

class UpdateOurWorkRequestModel {
  UpdateOurWorkRequestModel({
    this.id,
    this.ourWork,
  });

  String id;
  String ourWork;

  factory UpdateOurWorkRequestModel.fromJson(Map<String, dynamic> json) => UpdateOurWorkRequestModel(
    id: json["ID"],
    ourWork: json["OurWork"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "OurWork": ourWork,
  };
}
UpdateOurWorkResponseModel updateOurWorkResponseModelFromJson(String str) => UpdateOurWorkResponseModel.fromJson(json.decode(str));

String updateOurWorkResponseModelToJson(UpdateOurWorkResponseModel data) => json.encode(data.toJson());

class UpdateOurWorkResponseModel {
  UpdateOurWorkResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory UpdateOurWorkResponseModel.fromJson(Map<String, dynamic> json) => UpdateOurWorkResponseModel(
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
  };
}
