import 'dart:convert';

class FeedbackRequestModel {
  String Id;
  String feedback;
  bool isStudent;
  bool isOrganization;

  FeedbackRequestModel(
      {this.Id, this.feedback, this.isStudent, this.isOrganization});

  toJson() {
    Map<String, dynamic> map = {
      'CreatedBy': Id,
      'Description': feedback,
      'IsStudent': isStudent,
      'IsOrg': isOrganization
    };
    return jsonEncode(map);
  }
}

FeedbackResponseModel feedbackResponseModelFromJson(String str) =>
    FeedbackResponseModel.fromJson(json.decode(str));

String feedbackResponseModelToJson(FeedbackResponseModel data) =>
    json.encode(data.toJson());

class FeedbackResponseModel {
  FeedbackResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory FeedbackResponseModel.fromJson(Map<String, dynamic> json) =>
      FeedbackResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
