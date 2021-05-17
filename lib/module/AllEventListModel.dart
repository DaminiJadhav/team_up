// To parse this JSON data, do
//
//     final eventNdAdsModel = eventNdAdsModelFromJson(jsonString);

import 'dart:convert';

EventNdAdsModel eventNdAdsModelFromJson(String str) => EventNdAdsModel.fromJson(json.decode(str));

String eventNdAdsModelToJson(EventNdAdsModel data) => json.encode(data.toJson());

class EventNdAdsModel {
  EventNdAdsModel({
    this.status,
    this.message,
    this.eventAddDetails,
  });

  int status;
  String message;
  List<EventAddDetail> eventAddDetails;

  factory EventNdAdsModel.fromJson(Map<String, dynamic> json) => EventNdAdsModel(
    status: json["Status"],
    message: json["Message"],
    eventAddDetails: List<EventAddDetail>.from(json["EventAddDetails"].map((x) => EventAddDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "EventAddDetails": List<dynamic>.from(eventAddDetails.map((x) => x.toJson())),
  };
}

class EventAddDetail {
  EventAddDetail({
    this.id,
    this.name,
    this.description,
    this.publisherName,
    this.isEvent,
    this.date,
    this.poster,
    this.posterStatus,
    this.contentStatus,
    this.mobileNo,
    this.email,
    this.formattedDate,
  });

  int id;
  String name;
  String description;
  String publisherName;
  bool isEvent;
  DateTime date;
  String poster;
  bool posterStatus;
  bool contentStatus;
  String mobileNo;
  String email;
  String formattedDate;

  factory EventAddDetail.fromJson(Map<String, dynamic> json) => EventAddDetail(
    id: json["Id"],
    name: json["Name"],
    description: json["Description"],
    publisherName: json["PublisherName"],
    isEvent: json["IsEvent"],
    date: DateTime.parse(json["Date"]),
    poster: json["Poster"],
    posterStatus: json["PosterStatus"],
    contentStatus: json["ContentStatus"],
    mobileNo: json["MobileNo"],
    email: json["Email"],
    formattedDate: json["FormattedDate"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Description": description,
    "PublisherName": publisherName,
    "IsEvent": isEvent,
    "Date": date.toIso8601String(),
    "Poster": poster,
    "PosterStatus": posterStatus,
    "ContentStatus": contentStatus,
    "MobileNo": mobileNo,
    "Email": email,
    "FormattedDate": formattedDate,
  };
}
