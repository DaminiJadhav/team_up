import 'package:teamup/module/HackathonTeamDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class HackathonTeamDetailsContract {
  void showSuccess(HackathonTeamDetailsModel detailsModel);

  void showError(FetchException exception);
}
