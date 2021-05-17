import 'package:teamup/module/OAddProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class OAddProjectContract {
  void showOAddSuccess(OAddProjectResponseModel oAddProjectResponseModel);

  void showOAddError(FetchException exception);
}
