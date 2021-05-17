import 'dart:convert';

class PostAdRequestModel {
  String heading;
  String publisherName;
  String content;
  String poster;
  String email;
  String contact;
  String orgId;
  String stdId;
  bool posterStatus;
  bool contentStatus;
  String startDate;
  String endDate;

  PostAdRequestModel(
      {this.heading,
      this.publisherName,
      this.content,
      this.poster,
      this.email,
      this.contact,
      this.orgId,
      this.stdId,
      this.posterStatus,
      this.contentStatus,
      this.startDate,
      this.endDate});

  toJson() {
    Map<String, dynamic> map = {
      'Heading': heading,
      'PublisherName': publisherName,
      'Description': content,
      'Email': email,
      'ContactNo': contact,
      'OrgId': orgId,
      'StdId': stdId,
      'PosterStatus': posterStatus,
      'ContentStatus': contentStatus,
      'Poster': poster,
      'StartDate': startDate,
      'EndDate': endDate
    };
    return jsonEncode(map);
  }
}

PostAdResponseModel postAdResponseModelFromJson(String str) =>
    PostAdResponseModel.fromJson(json.decode(str));

String postAdResponseModelToJson(PostAdResponseModel data) =>
    json.encode(data.toJson());

class PostAdResponseModel {
  PostAdResponseModel({
    this.status,
    this.message,
  });

  int status;
  String message;

  factory PostAdResponseModel.fromJson(Map<String, dynamic> json) =>
      PostAdResponseModel(
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
      };
}
