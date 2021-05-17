import 'package:teamup/module/AllEventListModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class AllEventListContract {
  void showSuccess(EventNdAdsModel success);

  void showError(FetchException exception);
}
