import 'package:teamup/module/OrganizationChangeLogoModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class OrganizationChangeLogoContract {
  void showSuccess(OrganizationChangeLogoResponseModel responseModel);

  void showError(FetchException exception);
}
