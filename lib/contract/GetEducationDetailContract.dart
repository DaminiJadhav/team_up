import 'package:teamup/module/GetEducationalDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class GetEducationDetailContract {
  void showGetEducationDetailSuccess(
      GetEducationDetailModel educationDetailModel);

  void showGetEducationDetailError(FetchException exception);
}
