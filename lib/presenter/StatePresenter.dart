import 'package:teamup/contract/StateContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class StatePresenter {
  StateContract _view;
  Repos _repos;

  StatePresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getState(url) {
    _repos
        .getStateList(url)
        .then((value) => _view.showStateSuccess(value))
        .catchError((onError) =>
            _view.showStateError(new FetchException(onError.toString())));
  }
}
