import 'dart:convert';

AllAccomplishmentModel allAccomplishmentModelFromJson(String str) => AllAccomplishmentModel.fromJson(json.decode(str));

String allAccomplishmentModelToJson(AllAccomplishmentModel data) => json.encode(data.toJson());

class AllAccomplishmentModel {
  AllAccomplishmentModel({
    this.status,
    this.message,
    this.certificate,
  });

  int status;
  String message;
  List<Certificate> certificate;

  factory AllAccomplishmentModel.fromJson(Map<String, dynamic> json) => AllAccomplishmentModel(
    status: json["Status"],
    message: json["Message"],
    certificate: List<Certificate>.from(json["Certificate"].map((x) => Certificate.fromJson(x))),
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
  });

  int id;
  String name;
  String issuedAuthorityName;
  String issuedDate;

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
    id: json["ID"],
    name: json["Name"],
    issuedAuthorityName: json["IssuedAuthorityName"],
    issuedDate: json["IssuedDate"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "IssuedAuthorityName": issuedAuthorityName,
    "IssuedDate": issuedDate,
  };
}
