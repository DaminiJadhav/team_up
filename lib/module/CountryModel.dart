import 'dart:convert';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  CountryModel({
    this.status,
    this.message,
    this.countries,
  });

  int status;
  String message;
  List<Country> countries;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    status: json["Status"],
    message: json["Message"],
    countries: List<Country>.from(json["Countries"].map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Countries": List<dynamic>.from(countries.map((x) => x.toJson())),
  };
}

class Country {
  Country({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["ID"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
  };
}