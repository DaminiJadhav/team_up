import 'package:teamup/module/UpdatePersonDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class UpdatePersonDetailsContract {
  void showUpdatePersonDetailsSuccess(
      UpdatePersonDetailsResponseModel personDetailsModel);

  void showUpdatePersonDetailsError(FetchException exception);
}
