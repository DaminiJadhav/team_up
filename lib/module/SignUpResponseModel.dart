
class SignUpResponseModel{
  String ResponseStatus;
  String ResponseMessage;
  String ResponseId;

  SignUpResponseModel({this.ResponseStatus, this.ResponseMessage, this.ResponseId});
  // SignUpResponseModel.fromMap(Map<String,dynamic> map):
  // ResponseStatus = map['Status'],
  // ResponseMessage = map['Message'],
  // ResponseId = map['Id'];
  factory SignUpResponseModel.fromJson(Map<String,dynamic>json){
    return SignUpResponseModel(
      ResponseStatus: json['Status'],
      ResponseMessage: json['Message'],
      ResponseId: json['Id'],
    );
  }
}