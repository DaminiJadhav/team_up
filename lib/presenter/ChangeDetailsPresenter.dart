import 'package:teamup/contract/ChangeDetailsContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class ChangeDetailsPresenter {
  ChangeDetailsContract _view;
  Repos _repos;

  ChangeDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void changeName(ChangeNameRequestModel, url) {
    _repos
        .updateName(ChangeNameRequestModel, url)
        .then((value) => _view.showChangeSuccess(value))
        .catchError((onError) =>
            _view.showChangeError(new FetchException(onError.toString())));
  }

  void changeEmailId(ChangeEmailIdRequestModel, url) {
    _repos
        .updateEmail(ChangeEmailIdRequestModel, url)
        .then((value) => _view.showChangeSuccess(value))
        .catchError((onError) =>
            _view.showChangeError(new FetchException(onError.toString())));
  }

  void changePassword(ChangePasswordRequestModel, url) {
    _repos
        .updatePassword(ChangePasswordRequestModel, url)
        .then((value) => _view.showChangeSuccess(value))
        .catchError((onError) =>
            _view.showChangeError(new FetchException(onError.toString())));
  }
}
