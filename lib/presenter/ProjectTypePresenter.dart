import 'package:teamup/contract/ProjectTypeContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class ProjectTypePresenter {
  ProjectTypeContract _view;
  Repos _repos;

  ProjectTypePresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getPTList(url) {
    _repos
        .getProjectTypeList(url)
        .then((value) => _view.showProjectTypeSuccess(value))
        .catchError((onError) =>
            _view.showProjectTypeError(new FetchException(onError.toString())));
  }
}
