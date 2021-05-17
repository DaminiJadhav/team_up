import 'package:teamup/contract/GetHackathonDetailsContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class GetHackathonDetailsPresenter {
  GetHackathonDetailsContract _view;
  Repos _repos;

  GetHackathonDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void hackathonDetails(url) {
    _repos
        .getHackathonDetails(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
