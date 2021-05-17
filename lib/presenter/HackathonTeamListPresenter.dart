import 'package:teamup/contract/HackathonTeamListContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class HackathonTeamListPresenter {
  HackathonTeamListContract _view;
  Repos _repos;

  HackathonTeamListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getList(url) {
    _repos
        .getHackathonTeamList(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
