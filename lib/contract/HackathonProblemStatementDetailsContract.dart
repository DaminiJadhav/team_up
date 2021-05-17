import 'package:teamup/module/HackathonProblemStatementDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class HackathonProblemStatementDetailsContract {
  void showSuccess(HackathonProblemStatementDetailsModel successModel);

  void showError(FetchException exception);
}
