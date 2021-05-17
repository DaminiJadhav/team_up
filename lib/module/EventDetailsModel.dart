// To parse this JSON data, do
//
//     final eventDetailsModel = eventDetailsModelFromJson(jsonString);

import 'dart:convert';

EventDetailsModel eventDetailsModelFromJson(String str) => EventDetailsModel.fromJson(json.decode(str));

String eventDetailsModelToJson(EventDetailsModel data) => json.encode(data.toJson());

class EventDetailsModel {
  EventDetailsModel({
    this.status,
    this.message,
    this.event,
  });

  int status;
  String message;
  List<Event> event;

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) => EventDetailsModel(
    status: json["Status"],
    message: json["Message"],
    event: List<Event>.from(json["Event"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Event": List<dynamic>.from(event.map((x) => x.toJson())),
  };
}

class Event {
  Event({
    this.id,
    this.eventName,
    this.publisherName,
    this.posterStatus,
    this.contentStatus,
    this.poster,
    this.description,
    this.email,
    this.contactNo,
    this.address,
    this.date,
  });

  int id;
  String eventName;
  String publisherName;
  bool posterStatus;
  bool contentStatus;
  String poster;
  String description;
  String email;
  String contactNo;
  String address;
  String date;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["ID"],
    eventName: json["EventName"],
    publisherName: json["PublisherName"],
    posterStatus: json["PosterStatus"],
    contentStatus: json["ContentStatus"],
    poster: json["Poster"],
    description: json["Description"],
    email: json["Email"],
    contactNo: json["ContactNo"],
    address: json["Address"],
    date: json["Date"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "EventName": eventName,
    "PublisherName": publisherName,
    "PosterStatus": posterStatus,
    "ContentStatus": contentStatus,
    "Poster": poster,
    "Description": description,
    "Email": email,
    "ContactNo": contactNo,
    "Address": address,
    "Date": date,
  };
}
