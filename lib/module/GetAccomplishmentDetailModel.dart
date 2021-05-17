import 'dart:convert';

GetAccomplishmentDetailModel getAccomplishmentDetailModelFromJson(String str) =>
    GetAccomplishmentDetailModel.fromJson(json.decode(str));

String getAccomplishmentDetailModelToJson(GetAccomplishmentDetailModel data) =>
    json.encode(data.toJson());

class GetAccomplishmentDetailModel {
  GetAccomplishmentDetailModel({
    this.status,
    this.message,
    this.certificate,
  });

  int status;
  String message;
  List<Certificate> certificate;

  factory GetAccomplishmentDetailModel.fromJson(Map<String, dynamic> json) =>
      GetAccomplishmentDetailModel(
        status: json["Status"],
        message: json["Message"],
        certificate: List<Certificate>.from(
            json["Certificate"].map((x) => Certificate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Certificate": List<dynamic>.from(certificate.map((x) => x.toJson())),
      };
}

class Certificate {
  Certificate({
    this.id,
    this.name,
    this.issuedAuthorityName,
    this.issuedDate,
    this.createdOn,
  });

  int id;
  String name;
  String issuedAuthorityName;
  String issuedDate;
  DateTime createdOn;

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        id: json["ID"],
        name: json["Name"],
        issuedAuthorityName: json["IssuedAuthorityName"],
        issuedDate: json["IssuedDate"],
        createdOn: DateTime.parse(json["CreatedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "IssuedAuthorityName": issuedAuthorityName,
        "IssuedDate": issuedDate,
        "CreatedOn": createdOn.toIso8601String(),
      };
}
