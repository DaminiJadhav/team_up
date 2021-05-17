import 'dart:convert';

GenerateCertificateRequestModel generateCertificateRequestModelFromJson(String str) => GenerateCertificateRequestModel.fromJson(json.decode(str));

String generateCertificateRequestModelToJson(GenerateCertificateRequestModel data) => json.encode(data.toJson());

class GenerateCertificateRequestModel {
  GenerateCertificateRequestModel({
    this.projectId,
    this.userId,
    this.isStd,
  });

  String projectId;
  int userId;
  bool isStd;

  factory GenerateCertificateRequestModel.fromJson(Map<String, dynamic> json) => GenerateCertificateRequestModel(
    projectId: json["ProjectId"],
    userId: json["UserId"],
    isStd: json["IsStd"],
  );

  Map<String, dynamic> toJson() => {
    "ProjectId": projectId,
    "UserId": userId,
    "IsStd": isStd,
  };
}

GenerateCertificateResponseModel generateCertificateResponseModelFromJson(String str) => GenerateCertificateResponseModel.fromJson(json.decode(str));

String generateCertificateResponseModelToJson(GenerateCertificateResponseModel data) => json.encode(data.toJson());

class GenerateCertificateResponseModel {
  GenerateCertificateResponseModel({
    this.status,
    this.message,
    this.certificatePath,
  });

  int status;
  String message;
  String certificatePath;

  factory GenerateCertificateResponseModel.fromJson(Map<String, dynamic> json) => GenerateCertificateResponseModel(
    status: json["status"],
    message: json["Message"],
    certificatePath: json["CertificatePath"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "Message": message,
    "CertificatePath": certificatePath,
  };
}