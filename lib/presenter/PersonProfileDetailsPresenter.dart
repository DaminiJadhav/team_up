import 'package:teamup/contract/PersonProfileDetailsContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class PersonProfileDetailsPresenter {
  PersonProfileDetailsContract _view;
  Repos _repos;

  PersonProfileDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void personProfileDetails(url) {
    _repos
        .getPersonProfile(url)
        .then((value) => _view.showPersonProfileDetailsSuccess(value))
        .catchError((onError) => _view.showPersonProfileDetailsError(
            new FetchException(onError.toString())));
  }
}
