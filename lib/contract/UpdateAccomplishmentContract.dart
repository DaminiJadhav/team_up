import 'package:teamup/module/UpdateAccomplishmentModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class UpdateAccomplishmentContract {
  void showUpdateAccomplishmentSuccess(
      UpdateAccomplishmentResponseModel updateAccomplishmentResponseModel);

  void showUpdateAccomplishmentError(FetchException exception);
}
