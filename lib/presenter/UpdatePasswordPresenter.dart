import 'package:teamup/contract/UpdatePasswordContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/UpdatePasswordModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class UpdatePasswordPresenter {
  UpdatePasswordContract _view;
  Repos _repos;

  UpdatePasswordPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void updatePassword(UpdatePasswordRequestModel, url) {
    _repos
        .updateNewPassword(UpdatePasswordRequestModel, url)
        .then((value) => _view.showSuccess(value))
        .catchError((onError) =>
            _view.showError(new FetchException(onError.toString())));
  }
}
