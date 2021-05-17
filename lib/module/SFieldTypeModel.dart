// To parse this JSON data, do
//
//     final sFieldTypeModel = sFieldTypeModelFromJson(jsonString);

import 'dart:convert';

SFieldTypeModel sFieldTypeModelFromJson(String str) => SFieldTypeModel.fromJson(json.decode(str));

String sFieldTypeModelToJson(SFieldTypeModel data) => json.encode(data.toJson());

class SFieldTypeModel {
  SFieldTypeModel({
    this.status,
    this.message,
    this.fields,
  });

  int status;
  String message;
  List<Field> fields;

  factory SFieldTypeModel.fromJson(Map<String, dynamic> json) => SFieldTypeModel(
    status: json["Status"],
    message: json["Message"],
    fields: List<Field>.from(json["Fields"].map((x) => Field.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Fields": List<dynamic>.from(fields.map((x) => x.toJson())),
  };
}

class Field {
  Field({
    this.id,
    this.fieldName,
  });

  int id;
  String fieldName;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    id: json["ID"],
    fieldName: json["FieldName"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "FieldName": fieldName,
  };
}