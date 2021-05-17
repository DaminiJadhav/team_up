
import 'package:teamup/module/OrganizationSignUpModel/OrganizationSignUpModelSecond.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class organizationSignUpSecondContract{

  void showSecondStepSuccess(orgSignUpSecondResponseModel success);
  void showSecondStepError(FetchException exception);

}