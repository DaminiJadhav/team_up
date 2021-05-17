import 'package:teamup/module/AddFounderModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class AddFounderContract {
  void showAddFounderSuccess(AddFounderResponseModel responseModel);

  void showAddFounderError(FetchException exception);
}
