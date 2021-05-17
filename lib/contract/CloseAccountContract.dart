import 'package:teamup/module/CloseAccountModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class CloseAccountContract {
  void showCloseAccountSuccess(CloseAccountResponseModel responseModel);

  void showCloseAccountError(FetchException exception);
}
