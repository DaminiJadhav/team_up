import 'package:teamup/module/ApproveProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class ApproveProjectContract {
  void showApproveSuccess(ApproveProjectResponseModel responseModel);

  void showApproveError(FetchException exception);
}
