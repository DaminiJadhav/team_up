import 'package:teamup/module/PostEventModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class PostEventContract {
  void showPostEventSuccess(PostEventResponseModel responseModel);

  void showPostEventError(FetchException exception);
}
