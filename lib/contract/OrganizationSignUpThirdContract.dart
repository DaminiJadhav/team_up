
import 'package:teamup/module/OrganizationSignUpModel/OrganizationSignUpModelThird.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class organizationSignUpThirdContract{

  void showThirdStepSuccess(orgSignUpThirdResponseModel success);
  void showThirdStepError(FetchException exception);

}