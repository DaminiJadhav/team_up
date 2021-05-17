import 'package:teamup/contract/LegelsContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class LegalsPresenter {
  LegelsContract _view;
  Repos _repos;

  LegalsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void legals(url) {
    _repos
        .getLegals(url)
        .then((value) => _view.showLegelsSucess(value))
        .catchError((onError) =>
            _view.showLegalsError(new FetchException(onError.toString())));
  }
}
