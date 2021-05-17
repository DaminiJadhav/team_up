import 'package:teamup/contract/AddAccomplishmentContract.dart';
import 'package:teamup/dependancyInjection/Injector.dart';
import 'package:teamup/module/AddAccomplishmentModel.dart';
import 'package:teamup/utils/FetchException.dart';
import 'package:teamup/webService/Repository/Repos.dart';

class AddAccomplishmentPresenter {
  AddAccomplishmentContract _view;
  Repos _repos;

  AddAccomplishmentPresenter(this._view) {
    _repos = new Injector().repos;
  }

  void accomplishmentAdd(AddAccomplishmentRequestModel, url) {
    _repos
        .addAccomplishment(AddAccomplishmentRequestModel, url)
        .then((value) => _view.showAccomplishmentSuccess(value))
        .catchError((onError) => _view
            .showAccomplishmentError(new FetchException(onError.toString())));
  }
}
