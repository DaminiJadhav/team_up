import 'package:teamup/module/OrganizationProfileModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class OrganizationProfileContract {
  void showOrganizationSuccess(OrganizationProfileModel profileModel);

  void showOrganizationError(FetchException exception);
}
