import 'package:teamup/contract/OnGoingProjectContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class OnGoingProjectPresenter {
  OnGoingProjectContract _view;
  Repos _repos;

  OnGoingProjectPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getOnProjectList(url) {
    _repos
        .getOnGoingProject(url)
        .then((value) => _view.showOnGoingProjectSuccess(value))
        .catchError((onError) => _view
            .showOnGoingProjectError(new FetchException(onError.toString())));
  }
}
