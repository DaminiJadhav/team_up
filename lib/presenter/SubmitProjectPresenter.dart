import 'package:teamup/contract/SubmitProjectContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/SubmitProjectModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class SubmitProjectPresenter {
  SubmitProjectContract _view;
  Repos _repos;

  SubmitProjectPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void projectSubmit(SubmitProjectRequestModel, url) {
    _repos
        .submitProject(SubmitProjectRequestModel, url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
