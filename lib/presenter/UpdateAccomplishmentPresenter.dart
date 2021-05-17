import 'package:teamup/contract/UpdateAccomplishmentContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/UpdateAccomplishmentModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class UpdateAccomplishmentPresenter {
  UpdateAccomplishmentContract _view;
  Repos _repos;

  UpdateAccomplishmentPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void accomplishmentUpdate(UpdateAccomplishmentModel, url) {
    _repos
        .updateAccomplishment(UpdateAccomplishmentModel, url)
        .then((value) => _view.showUpdateAccomplishmentSuccess(value))
        .catchError((onError) => _view.showUpdateAccomplishmentError(
            new FetchException(onError.toString())));
  }
}
