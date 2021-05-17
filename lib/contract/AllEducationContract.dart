import 'package:teamup/module/AllEducationModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class AllEducationContract {
  void showEducationSuccess(AllEducationModel allEducationModel);

  void showEducationError(FetchException exception);
}
