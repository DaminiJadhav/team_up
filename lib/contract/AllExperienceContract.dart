import 'package:teamup/module/AllExperienceModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class AllExperienceContract {
  void showAllExperienceSuccess(AllExperienceModel allExperienceModel);

  void showAllExperienceError(FetchException exception);
}
