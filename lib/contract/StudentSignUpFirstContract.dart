import 'package:teamup/module/SignUpRequestModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class studentSignUpFirstContract{
  void showStudentSignUpSuccess(SignUpFirstResponseModel success);
  void showStudentSignUpError(FetchException exception);
}