import 'package:teamup/module/GetHackathonDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class GetHackathonDetailsContract {
  void showSuccess(GetHackathonDetailsModel hackathonDetailsModel);

  void showError(FetchException exception);
}
