import 'package:teamup/module/GetEducationalDetailsModel.dart';
import 'package:teamup/module/GetExperienceDetailModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class GetExperienceDetailContract {
  void showGetExperienceDetailSuccess(
      GetExperienceDetailModel experienceDetailModel);

  void showGetExperienceDetailError(FetchException exception);
}
