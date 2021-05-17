import 'package:teamup/module/LoginRequestModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class LoginContract{
  void showLoginSuccess(LoginResponseModel success);
  void showLoginError(FetchException exception);
}