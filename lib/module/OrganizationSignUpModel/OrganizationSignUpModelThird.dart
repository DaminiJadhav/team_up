import 'dart:convert';
import 'dart:convert';

OrgSignUpThird orgSignUpThirdFromJson(String str) => OrgSignUpThird.fromJson(json.decode(str));

String orgSignUpThirdToJson(OrgSignUpThird data) => json.encode(data.toJson());

class OrgSignUpThird {
  OrgSignUpThird({
    this.id,
    this.username,
    this.password,
    this.address,
    this.city,
    this.state,
    this.country,
  });

  String id;
  String username;
  String password;
  String address;
  String city;
  String state;
  String country;

  factory OrgSignUpThird.fromJson(Map<String, dynamic> json) => OrgSignUpThird(
    id: json["ID"],
    username: json["USERNAME"],
    password: json["PASSWORD"],
    address: json["ADDRESS"],
    city: json["CITY"],
    state: json["STATE"],
    country: json["COUNTRY"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "USERNAME": username,
    "PASSWORD": password,
    "ADDRESS": address,
    "CITY": city,
    "STATE": state,
    "COUNTRY": country,
  };
}


class orgSignUpThirdResponseModel {
  int Status;
  String Message;

  orgSignUpThirdResponseModel({this.Status, this.Message});
}
