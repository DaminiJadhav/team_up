

import 'package:teamup/module/SignUpRequestModelSecond.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class studentSignUpSecondContract{
  void showStudentSignUpSecondSuccess(SignUpResponseModelSecond success);
  void showStudentSignUpSecondError(FetchException exception);
}