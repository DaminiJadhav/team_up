import 'package:teamup/module/ChangePersonalDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class ChangeDetailsContract {
  void showChangeSuccess(ChangeResponseModel responseModel);

  void showChangeError(FetchException exception);
}
