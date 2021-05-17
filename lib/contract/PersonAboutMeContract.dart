import 'package:teamup/module/PersonAboutMeModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class PersonAboutMeContract {
  void showAboutMeUpdateSuccess(
      PersonAboutMeResponseModel aboutMeResponseModel);

  void showAboutMeUpdateError(FetchException exception);
}
