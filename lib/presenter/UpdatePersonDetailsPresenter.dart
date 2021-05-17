import 'package:teamup/contract/UpdatePersonDetailsContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/UpdatePersonDetailsModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class UpdatePersonDetailsPresenter {
  UpdatePersonDetailsContract _view;
  Repos _repos;

  UpdatePersonDetailsPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void updateInfo(UpdatePersonDetailsModel, url) {
    _repos
        .updatePersonDetails(UpdatePersonDetailsModel, url)
        .then((value) => _view.showUpdatePersonDetailsSuccess(value))
        .catchError((onError) => _view.showUpdatePersonDetailsError(
            new FetchException(onError.toString())));
  }
}
