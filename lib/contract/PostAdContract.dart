import 'package:teamup/module/PostAdModel.dart';
import 'package:teamup/utils/FetchException.dart';

abstract class PostAdContract {
  void showPostAdSuccess(PostAdResponseModel adResponseModel);

  void showPostAdError(FetchException exception);
}
