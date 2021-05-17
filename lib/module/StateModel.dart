// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) =>
    StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  StateModel({
    this.status,
    this.message,
    this.states,
  });

  int status;
  String message;
  List<States> states;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        status: json["Status"],
        message: json["Message"],
        states: List<States>.from(json["States"].map((x) => States.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "States": List<dynamic>.from(states.map((x) => x.toJson())),
      };
}

class States {
  States({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory States.fromJson(Map<String, dynamic> json) => States(
        id: json["ID"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
      };
}
