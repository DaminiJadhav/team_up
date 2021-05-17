import 'package:teamup/module/FounderDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class FounderDetailsContract {
  void showFounderSuccess(FounderDetailsModel founderDetailsModel);

  void showFounderError(FetchException exception);
}
