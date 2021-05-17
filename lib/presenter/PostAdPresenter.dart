import 'package:teamup/contract/PostAdContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/PostAdModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class PostAdPresenter {
  PostAdContract _view;
  Repos _repos;

  PostAdPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void postAd(PostAdRequestModel, url) {
    _repos
        .postAds(PostAdRequestModel, url)
        .then((value) => _view.showPostAdSuccess(value))
        .catchError((onError) =>
            _view.showPostAdError(new FetchException(onError.toString())));
  }
}
