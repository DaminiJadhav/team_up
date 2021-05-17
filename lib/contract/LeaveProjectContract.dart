import 'package:teamup/module/LeaveProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class LeaveProjectContract {
  void showSuccess(LeaveProjectResponseModel responseModel);

  void showError(FetchException exception);
}
