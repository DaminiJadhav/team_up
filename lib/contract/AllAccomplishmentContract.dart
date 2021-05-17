import 'package:teamup/module/AllAccomplishmentModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class AllAccomplishmentContract {
  void showAllAccomplishmentSuccess(AllAccomplishmentModel accomplishmentModel);

  void showAllAccomplishmentError(FetchException exception);
}
