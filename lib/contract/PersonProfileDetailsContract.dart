import 'package:teamup/module/PersonProfileDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class PersonProfileDetailsContract {
  void showPersonProfileDetailsSuccess(
      PersonProfileDetailsModel profileDetailsModel);

  void showPersonProfileDetailsError(FetchException exception);
}
