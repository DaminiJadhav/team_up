import 'package:teamup/module/AddAccomplishmentModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class AddAccomplishmentContract {
  void showAccomplishmentSuccess(
      AddAccomplishmentResponseModel accomplishmentResponseModel);

  void showAccomplishmentError(FetchException exception);
}
