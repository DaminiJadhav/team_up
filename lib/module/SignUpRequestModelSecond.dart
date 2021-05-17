import 'dart:convert';

class SignUpRequestModelSecond{
  String ID;
  String Firstname;
  String Lastname;
  String Email;
  String Phone;
  String SMSCode;
  String EmailCode;
  bool TermConditions;

  SignUpRequestModelSecond({this.ID, this.Firstname, this.Lastname, this.Email,
      this.Phone, this.SMSCode, this.EmailCode, this.TermConditions});

  toJson() {
    Map<String, dynamic> map = {
      'ID': ID.trim(),
      'Firstname': Firstname.trim(),
      'Lastname':Lastname.trim(),
      'Email':Email.trim(),
      'Phone' : Phone.trim(),
      'SMSCode':SMSCode.trim(),
      'EmailCode':EmailCode.trim(),
      'TermConditions': TermConditions,
    };
    return jsonEncode(map);
  }

}
class SignUpResponseModelSecond{
  int Id;
  int Status;
  String Message;
  SignUpResponseModelSecond({this.Id,this.Status,this.Message});


}
