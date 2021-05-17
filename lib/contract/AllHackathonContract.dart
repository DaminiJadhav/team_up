import 'package:teamup/module/AllHackathonModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class AllHackathonContract {
  void showSuccess(AllHackathonModel hackathonModel);

  void showError(FetchException exception);
}
