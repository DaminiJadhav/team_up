import 'dart:convert';

class GetFeedbackRequestModel {
  String id;
  bool isStudent;
  bool isOrganization;

  GetFeedbackRequestModel({this.id, this.isStudent, this.isOrganization});

  toJson() {
    Map<String, dynamic> map = {
      'CreatedBy': id,
      'IsStudent': isStudent,
      'IsOrg': isOrganization,
    };
    return jsonEncode(map);
  }
}

GetFeedbackResponseModel getFeedbackResponseModelFromJson(String str) =>
    GetFeedbackResponseModel.fromJson(json.decode(str));

String getFeedbackResponseModelToJson(GetFeedbackResponseModel data) =>
    json.encode(data.toJson());

class GetFeedbackResponseModel {
  GetFeedbackResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory GetFeedbackResponseModel.fromJson(Map<String, dynamic> json) =>
      GetFeedbackResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
