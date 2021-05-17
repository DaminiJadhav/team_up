import 'package:teamup/module/GetProjectDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class GetProjectDetailsContract {
  void showProjectDetailsSuccess(GetProjectDetailsModel detailsModel);

  void showProjectDetailsError(FetchException exception);
}
