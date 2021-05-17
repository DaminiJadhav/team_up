import 'package:teamup/module/RejectProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class RejectProjectContract {
  void showRejectSuccess(RejectProjectResponseModel responseModel);

  void showRejectError(FetchException exception);
}
