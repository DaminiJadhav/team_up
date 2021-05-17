import 'package:teamup/module/AddHackathonModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class AddHackathonContract {
  void showSuccess(AddHackathonResponseModel successModel);

  void showError(FetchException exception);
}
