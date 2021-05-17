import 'package:teamup/contract/AllFoundersContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class AllFoundersPresenter {
  AllFoundersContract _view;
  Repos _repos;

  AllFoundersPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getFounders(url) {
    _repos
        .getAllFoundersList(url)
        .then((value) => _view.showAllFoundersSuccess(value))
        .catchError((onError) =>
            _view.showAllFoundersError(new FetchException(onError.toString())));
  }
}
