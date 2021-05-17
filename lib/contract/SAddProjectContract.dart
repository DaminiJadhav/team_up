import 'package:teamup/module/SAddProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class SAddProjectContract {
  void showSAddProjectSuccess(SAddProjectResponseModel success);

  void showSAddProjectError(FetchException exception);
}
