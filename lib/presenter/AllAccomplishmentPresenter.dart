import 'package:teamup/contract/AllAccomplishmentContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class AllAccomplishmentPresenter {
  AllAccomplishmentContract _view;
  Repos _repos;

  AllAccomplishmentPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void allAccomplishment(url) {
    _repos
        .getAllAccomplishment(url)
        .then((value) => _view.showAllAccomplishmentSuccess(value))
        .catchError((onError) => _view.showAllAccomplishmentError(
            new FetchException(onError.toString())));
  }
}
