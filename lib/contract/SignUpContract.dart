
import 'package:teamup/module/SignUpResponseModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class SignUpContract{
  void showSuccess(String item);
  void showError(FetchException e);
}
