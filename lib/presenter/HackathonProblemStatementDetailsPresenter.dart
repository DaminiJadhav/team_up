import 'package:teamup/contract/HackathonProblemStatementDetailsContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class HackathonProblemStatementDetailsPresenter {
  HackathonProblemStatementDetailsContract _view;
  Repos _repos;

  HackathonProblemStatementDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getDetails(url) {
    _repos
        .getHackathonProblemDetails(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
