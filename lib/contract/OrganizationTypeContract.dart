

import 'package:teamup/module/OrganizationTypeModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class OrganizationType{
  void showSuccess(List<OrganizationTypeModel> item);
  void showError(FetchException e);
}