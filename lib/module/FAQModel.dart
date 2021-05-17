import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  FaqModel({
    this.status,
    this.message,
    this.faq,
  });

  int status;
  String message;
  List<Faq> faq;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        status: json["Status"],
        message: json["Message"],
        faq: List<Faq>.from(json["FAQ"].map((x) => Faq.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "FAQ": List<dynamic>.from(faq.map((x) => x.toJson())),
      };
}

class Faq {
  Faq({
    this.id,
    this.faq1,
    this.answers,
  });

  int id;
  String faq1;
  String answers;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        id: json["ID"],
        faq1: json["FAQ1"],
        answers: json["Answers"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "FAQ1": faq1,
        "Answers": answers,
      };
}
