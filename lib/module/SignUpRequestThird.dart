import 'dart:convert';

class SignUpRequestThird {
  String ID;
  String Username;
  String Password;
  String City;
  String State;
  String Country;
  String Address;
  bool TermConditions;

  SignUpRequestThird({
    this.ID,
    this.Username,
    this.Password,
    this.City,
    this.Country,
    this.State,
    this.Address,
    this.TermConditions
  });

  toJson() {
    Map<String, dynamic> map = {
      'ID': ID.trim(),
      'Username': Username.trim(),
      'Password': Password.trim(),
      'Country': Country.trim(),
      'State': State.trim(),
      'City': City.trim(),
      'Address' : Address.trim(),
      'TermConditions':TermConditions,
    };
    return jsonEncode(map);
  }
}

class SignUpThirdResponseModel {
  int Status;
  String Message;

  SignUpThirdResponseModel({this.Status, this.Message});
}
