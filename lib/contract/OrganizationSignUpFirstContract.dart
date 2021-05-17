
import 'package:teamup/module/OrganizationSignUpModel/OrganizationSignUpModelFirst.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class organizationSignUpFirstContract{

  void showFirstStepSuccess(OrgSignUpFirstResponseModel success);
  void showFirstStepError(FetchException e);

}