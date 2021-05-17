import 'package:teamup/module/MyHackathonListModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class MyHackathonListContract {
  void showSuccess(MyHackathonListModel listModel);

  void showError(FetchException exception);
}
