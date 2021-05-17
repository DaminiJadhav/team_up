import 'package:teamup/contract/PostEventContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/PostEventModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class PostEventPresenter {
  PostEventContract _view;
  Repos _repos;

  PostEventPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void postEvent(PostEventRequestModel, url) {
    _repos
        .postEvents(PostEventRequestModel, url)
        .then((value) => _view.showPostEventSuccess(value))
        .catchError((onError) =>
            _view.showPostEventError(new FetchException(onError.toString())));
  }
}
