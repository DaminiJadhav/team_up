import 'package:teamup/contract/AllEventListContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class AllEventListPresenter {
  AllEventListContract _view;
  Repos _repos;

  AllEventListPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getAllEventList(url) {
    _repos
        .getAllEventList(url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
