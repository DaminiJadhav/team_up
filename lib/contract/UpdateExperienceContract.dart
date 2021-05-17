import 'package:teamup/module/UpdateExperienceModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class UpdateExperienceContract {
  void showUpdateExperienceSuccess(
      UpdateExperienceResponseModel updateExperienceResponseModel);

  void showUpdateExperienceError(FetchException exception);
}
