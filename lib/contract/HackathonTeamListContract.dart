import 'package:teamup/module/HackathonTeamListModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class HackathonTeamListContract {
  void showSuccess(HackathonTeamListModel hackathonTeamListModel);

  void showError(FetchException exception);
}
