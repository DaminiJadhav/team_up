
import 'package:teamup/module/SignUpRequestThird.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class studentSignUpThirdContract{
  void showStudentSignUpThirdSuccess(SignUpThirdResponseModel success);
  void showStudentSignUpThirdError(FetchException exception);
}