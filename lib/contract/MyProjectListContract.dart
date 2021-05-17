import 'package:teamup/module/MyProjectListModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class MyProjectListContract {
  void showSuccess(MyProjectListModel projectListModel);

  void showError(FetchException exception);
}
