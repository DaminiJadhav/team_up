import 'package:teamup/module/GetPersonDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class GetPersonDetailsContract {
  void showGetPersonDetailsSuccess(GetPersonDetailsModel personDetailsModel);

  void showGetPersonDetailsError(FetchException exception);
}
