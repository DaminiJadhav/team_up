import 'package:teamup/contract/HackathonTeamDetailsContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class HackathonTeamDetailsPresenter {
  HackathonTeamDetailsContract _view;
  Repos _repos;

  HackathonTeamDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getTeamDetails(url) {
    _repos
        .getHackathonTeamDetails(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
