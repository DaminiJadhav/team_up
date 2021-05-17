import 'package:teamup/module/ForgetPasswordModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class ForgetPasswordContract {
  void showForgetPasswordSuccess(
      ForgetPasswordResponseModel forgetPasswordResponseModel);

  void showForgetPasswordError(FetchException exception);
}
