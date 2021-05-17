import 'package:teamup/contract/PeopleTypeContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class PeopleTypePresenter {
  PeopleTypeContract _view;
  Repos _repos;

  PeopleTypePresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getPeopleList(url) {
    _repos
        .getPeopleTypeList(url)
        .then((value) => _view.showPeopleTypeSuccess(value))
        .catchError((onError) =>
            _view.showPeopleTypeError(new FetchException(onError.toString())));
  }
}
