import 'package:teamup/module/CollegeModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class CollegeContract {
  void showCollegeSuccess(CollegeModel collegeModel);

  void showCollegeError(FetchException exception);
}
