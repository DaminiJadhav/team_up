import 'package:teamup/contract/CollegeContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class CollegePresenter {
  CollegeContract _view;
  Repos _repos;

  CollegePresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getListOfColleges(url) {
    _repos
        .getCollegeList(url)
        .then((value) => _view.showCollegeSuccess(value))
        .catchError((onError) =>
            _view.showCollegeError(new FetchException(onError.toString())));
  }
}
