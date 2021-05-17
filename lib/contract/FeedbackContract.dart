import 'package:teamup/module/FeedbackModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class FeedbackContract {
  void showPostSuccess(FeedbackResponseModel responseModel);

  void showPostError(FetchException exception);
}
