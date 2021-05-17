import 'package:teamup/contract/SAddProjectContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/SAddProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class SAddProjectPresenter {
  SAddProjectContract _view;
  Repos _repos;

  SAddProjectPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void sPostProject(SAddProjectRequestModel, url) {
    _repos
        .addSProject(SAddProjectRequestModel, url)
        .then((value) => _view.showSAddProjectSuccess(value))
        .catchError((onError) =>
            _view.showSAddProjectError(new FetchException(onError.toString())));
  }
}
