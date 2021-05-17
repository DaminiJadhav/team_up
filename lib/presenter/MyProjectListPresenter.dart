import 'package:teamup/contract/MyProjectListContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class MyProjectListPresenter {
  MyProjectListContract _view;
  Repos _repos;

  MyProjectListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getList(url) {
    _repos
        .getMyProjectList(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
