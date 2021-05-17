import 'package:teamup/contract/OAddProjectContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/OAddProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class OAddProjectPresenter {
  OAddProjectContract _view;
  Repos _repos;

  OAddProjectPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void oAddProject(OAddProjectRequestModel, url) {
    _repos
        .addOProject(OAddProjectRequestModel, url)
        .then((value) => _view.showOAddSuccess(value))
        .catchError((onError) =>
            _view.showOAddError(new FetchException(onError.toString())));
  }
}
