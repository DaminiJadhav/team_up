import 'package:teamup/module/UpdatePasswordModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class UpdatePasswordContract {
  void showSuccess(UpdatePasswordResponseModel responseModel);

  void showError(FetchException exception);
}
