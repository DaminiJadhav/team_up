import 'package:teamup/module/MyProjectDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class MyProjectDetailsContract {
  void showSuccess(MyProjectDetailsModel detailsModel);

  void showError(FetchException exception);
}
