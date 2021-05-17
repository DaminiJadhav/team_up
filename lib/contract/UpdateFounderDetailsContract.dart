import 'package:teamup/module/UpdateFounderDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class UpdateFounderDetailsContract {
  void showFounderUpdateSuccess(
      UpdateFounderDetailsResponseModel responseModel);

  void showFounderUpdateError(FetchException exception);
}
