import 'package:teamup/contract/AllHackathonContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class AllHackathonPresenter {
  AllHackathonContract _view;
  Repos _repos;

  AllHackathonPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getListHackathon(url) {
    _repos
        .getAllHackathon(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
