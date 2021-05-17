import 'package:teamup/module/GetFeedbackModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class GetFeedbackContract {
  void showGetFeedbackSuccess(GetFeedbackResponseModel success);

  void showGetFeedbackError(FetchException exception);
}
