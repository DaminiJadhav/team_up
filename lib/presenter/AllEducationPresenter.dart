import 'package:teamup/contract/AllEducationContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class AllEducationPresenter {
  AllEducationContract _view;
  Repos _repos;

  AllEducationPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void getEducation(url) {
    _repos
        .getAllEducation(url)
        .then((value) => _view.showEducationSuccess(value))
        .catchError((onError) =>
            _view.showEducationError(new FetchException(onError.toString())));
  }
}
