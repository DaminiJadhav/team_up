import 'package:teamup/module/GetAccomplishmentDetailModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class GetAccomplishmentDetailContract {
  void showGetAccomplishmentDetailSuccess(
      GetAccomplishmentDetailModel accomplishmentDetailModel);

  void showGetAccomplishmentDetailError(FetchException exception);
}
