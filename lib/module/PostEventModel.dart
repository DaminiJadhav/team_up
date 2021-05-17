import 'dart:convert';

class PostEventRequestModel {
  String eventName;
  String poster;
  String content;
  String publisher;
  String eventDate;
  String orgId;
  String stdId;
  String address;
  String emailId;
  String mobileNumber;
  bool posterStatus;
  bool contentStatus;

  PostEventRequestModel(
      {this.eventName,
      this.poster,
      this.content,
      this.publisher,
      this.eventDate,
      this.orgId,
      this.stdId,
      this.address,
      this.emailId,
      this.mobileNumber,
      this.posterStatus,
      this.contentStatus});

  toJson() {
    Map<String, dynamic> map = {
      'EventName': eventName,
      'Description': content,
      'PublisherName': publisher,
      'Date': eventDate,
      'OrgId': orgId,
      'StdId': stdId,
      'Address': address,
      'Email': emailId,
      'ContactNo': mobileNumber,
      'PosterStatus': posterStatus,
      'ContentStatus': contentStatus,
      'Poster': poster,
    };
    return jsonEncode(map);
  }
}

PostEventResponseModel postEventResponseModelFromJson(String str) =>
    PostEventResponseModel.fromJson(json.decode(str));

String postEventResponseModelToJson(PostEventResponseModel data) =>
    json.encode(data.toJson());

class PostEventResponseModel {
  PostEventResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory PostEventResponseModel.fromJson(Map<String, dynamic> json) =>
      PostEventResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
