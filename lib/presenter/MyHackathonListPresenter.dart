import 'package:teamup/contract/MyHackathonListContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class MyHackathonListPresenter {
  MyHackathonListContract _view;
  Repos _repos;

  MyHackathonListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getMyList(url) {
    _repos
        .getMyHackathons(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
