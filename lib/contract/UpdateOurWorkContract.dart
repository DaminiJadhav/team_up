import 'package:teamup/module/UpdateOurWorkModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class UpdateOurWorkContract{
  void showOurWorkSuccess(UpdateOurWorkResponseModel responseModel);
  void showOurWorkError(FetchException exception);
}