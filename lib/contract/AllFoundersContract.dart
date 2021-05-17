import 'package:teamup/module/AllFoundersModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class AllFoundersContract {
  void showAllFoundersSuccess(AllFoundersModel foundersModel);

  void showAllFoundersError(FetchException exception);
}
