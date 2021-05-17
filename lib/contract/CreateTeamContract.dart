import 'package:teamup/module/CreateTeamModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class CreateTeamContract {
  void showSuccess(CreateTeamResponseModel createTeamResponseModel);

  void showError(FetchException exception);
}
