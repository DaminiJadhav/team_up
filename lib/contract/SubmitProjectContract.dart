import 'package:teamup/module/SubmitProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class SubmitProjectContract {
  void showSuccess(SubmitProjectResponseModel responseModel);

  void showError(FetchException exception);
}
