import 'package:teamup/module/AddEducationModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class AddEducationContract {
  void showAddEducationSuccess(AddEducationResponseModel responseModel);

  void showAddEducationError(FetchException exception);
}
