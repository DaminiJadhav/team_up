import 'dart:convert';

class orgSignUpSecond{

  String ID;
  String OrgName;
  String About_Us;
  String OrgTypeId;
  String Email;
  String Phone;
  String SMSCode;
  String EmailCode;
  bool TermConditions;

  orgSignUpSecond({
    this.ID,
    this.OrgName,
    this.About_Us,
    this.OrgTypeId,
    this.Email,
    this.Phone,
    this.SMSCode,
    this.EmailCode,
    this.TermConditions
});

  toJson(){
    Map<String, dynamic> map = {
      'ID' : ID.trim(),
      'OrgName' : OrgName.trim(),
      'About_Us' : About_Us.trim(),
      'OrgTypeId' : OrgTypeId.trim(),
      'Email' : Email.trim(),
      'Phone' : Phone.trim(),
      'SMSCode' : SMSCode.trim(),
      'EmailCode' : EmailCode.trim(),
      'TermConditions' : TermConditions

    };
    return jsonEncode(map);
  }
}

class orgSignUpSecondResponseModel{
  int Id;
  int Status;
  String Message;

  orgSignUpSecondResponseModel({this.Id,this.Message,this.Status});

}