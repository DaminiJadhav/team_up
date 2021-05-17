import 'package:teamup/module/AddEducationModel.dart';
import 'package:teamup/module/AddExperienceModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class AddExperienceContract {
  void showAddExperienceSuccess(
      AddExperienceResponseModel experienceResponseModel);

  void showAddExperienceError(FetchException exception);
}
