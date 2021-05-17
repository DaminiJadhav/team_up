import 'package:teamup/contract/SFieldContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class SFieldPresenter {
  SFieldContract _view;
  Repos _repos;

  SFieldPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getField(url) {
    _repos
        .getFieldList(url)
        .then((value) => _view.showSFieldSuccess(value))
        .catchError((onError) =>
            _view.showSFieldError(new FetchException(onError.toString())));
  }
}
